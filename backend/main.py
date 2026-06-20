from fastapi import FastAPI, Query
from fastapi.middleware.cors import CORSMiddleware
from serpapi import GoogleSearch
from dotenv import load_dotenv
import os

load_dotenv()

app = FastAPI(
    title="Smart Itinerary Planner API"
)

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