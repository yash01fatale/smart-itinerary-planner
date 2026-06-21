from urllib import request

from backend.models import generate_daywise_itinerary
from backend.models import rank_attractions
from fastapi import FastAPI, Query
from fastapi.middleware.cors import CORSMiddleware
from serpapi import GoogleSearch
from dotenv import load_dotenv
from pydantic import BaseModel

import os

load_dotenv()

app = FastAPI(
    title="Smart Itinerary Planner API"
)



class ItineraryRequest(BaseModel):
    destination: str
    days: int


app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

SERP_API_KEY = os.getenv("SERP_API_KEY")


@app.get("/")
def home():
    return {
        "status": "running",
        "message": "Smart Itinerary Planner Backend"
    }


@app.get("/destination-image")
def destination_image(place: str):
    return {
        "image":
        f"https://source.unsplash.com/1600x900/?{place},travel"
    }

@app.get("/popular-destinations")
def popular_destinations(
    country: str = Query("India")
):
    try:

        search = GoogleSearch({
            "engine": "google",
            "q": f"{country} tourist destinations",
            "api_key": SERP_API_KEY
        })

        results = search.get_dict()

        destination_data = (
            results.get("popular_destinations", {})
            .get("destinations", [])
        )

        destinations = []

        for item in destination_data:
            destinations.append({
                "title": item.get("title", ""),
                "description": item.get("description", ""),
                "link": item.get("link", ""),
                "flight_price": item.get("flight_price", ""),
                "extracted_flight_price": item.get("extracted_flight_price"),
                "hotel_price": item.get("hotel_price", ""),
                "extracted_hotel_price": item.get("extracted_hotel_price"),
                "thumbnail": DESTINATION_IMAGES.get(
                    item.get("title", ""),
                    "https://images.unsplash.com/photo-1506744038136-46273834b3fb"
                )   
            })

        return {
            "success": True,
            "count": len(destinations),
            "destinations": destinations
        }

    except Exception as e:
        return {
            "success": False,
            "error": str(e)
        }

@app.get("/search-destinations")
def search_destinations(query: str):

    try:

        search = GoogleSearch({
            "engine": "google",
            "q": f"{query} tourist destination",
            "api_key": SERP_API_KEY
        })

        results = search.get_dict()

        destinations = []

        for item in results.get(
            "organic_results",
            []
        )[:10]:

            destinations.append({
                "title": item.get("title", ""),
                "description": item.get("description", ""),
                "thumbnail": item.get(
                    "thumbnail",
                    f"https://source.unsplash.com/800x600/?{query}"
                ),
                "link": item.get("link", ""),
                "flight_price": item.get("flight_price", ""),
                "hotel_price": item.get("hotel_price", ""),
            })

        return {
            "success": True,
            "count": len(destinations),
            "destinations": destinations
        }

    except Exception as e:
        return {
            "success": False,
            "error": str(e)
        }
    
DESTINATION_IMAGES = {
    "Mumbai": "https://images.unsplash.com/photo-1570168007204-dfb528c6958f",
    "Jaipur": "https://images.unsplash.com/photo-1477587458883-47145ed94245",
    "New Delhi": "https://images.unsplash.com/photo-1587474260584-136574528ed5",
    "Goa": "https://images.unsplash.com/photo-1512343879784-a960bf40e7f2",
    "Bengaluru": "https://images.unsplash.com/photo-1596176530529-78163a4f7af2",
    "Varanasi": "https://images.unsplash.com/photo-1561361513-2d000a50f0dc",
    "Udaipur": "https://images.unsplash.com/photo-1615836245337-f5b9b2303f10",
    "Agra": "https://images.unsplash.com/photo-1564507592333-c60657eea523",
    "Kolkata": "https://images.unsplash.com/photo-1558431382-27e303142255",
    "Chennai": "https://images.unsplash.com/photo-1582510003544-4d00b7f74220"
}




def fetch_attractions(destination: str):

    search = GoogleSearch({
        "engine": "google_maps",
        "q": f"tourist attractions in {destination}",
        "type": "search",
        "api_key": SERP_API_KEY
    })

    results = search.get_dict()

    attractions = []

    for place in results.get("local_results", []):

        attractions.append({
            "name": place.get("title"),
            "rating": place.get("rating", 0),
            "reviews": place.get("reviews", 0),
            "address": place.get("address", ""),
            "thumbnail":place.get("thumbnail",""),
        })

    return attractions




@app.post("/generate-itinerary")
def create_itinerary(request: ItineraryRequest):

    print("Destination:", request.destination)
    print("Days:", request.days)

    attractions = fetch_attractions(
        request.destination
    )

    print(
        "Attractions Found:",
        len(attractions)
    )

    ranked = rank_attractions(
        attractions
    )

    itinerary = []

    places_per_day = max(
        1,
        len(ranked) // request.days
    )

    index = 0

    for day in range(request.days):

        day_places = ranked[
            index:index + places_per_day
        ]

        itinerary.append({
            "day": day + 1,
            "places": day_places
        })

        index += places_per_day

    if index < len(ranked):
        itinerary[-1]["places"].extend(
            ranked[index:]
        )

    return {
        "success": True,
        "destination": request.destination,
        "days": request.days,
        "itinerary": itinerary
    }



# if __name__ == "__main__":
#     result  =ItineraryRequest("mumbai,2")
#     res = fetch_attractions(result)
#     # print(res)
#     itin = create_itinerary(res,2)
#     print(itin)



