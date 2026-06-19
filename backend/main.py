from fastapi import FastAPI, Query
from fastapi.middleware.cors import CORSMiddleware
from serpapi import GoogleSearch
from dotenv import load_dotenv
import os

load_dotenv()

app = FastAPI(title="Smart Itinerary Planner API")

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

@app.get("/destination/{city}")
def get_destination(city: str):
    return DESTINATION_DETAILS.get(city, {})

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
"thumbnail": HD_IMAGES.get(
    item.get("title", ""),
    item.get("thumbnail", "")
)})

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
    
DESTINATION_DETAILS = {
"Mumbai": {
"best_time": "October - March",
"rating": 4.8,
"budget": "₹15,000 - ₹40,000",
"attractions": [
"Gateway of India",
"Marine Drive",
"Juhu Beach",
"Elephanta Caves"
],
"things_to_do": [
"Street Food Tour",
"Shopping",
"Beach Walk",
"Bollywood Tour"
]
},

"Goa": {
    "best_time": "November - February",
    "rating": 4.9,
    "budget": "₹20,000 - ₹50,000",
    "attractions": [
        "Baga Beach",
        "Calangute Beach",
        "Fort Aguada"
    ],
    "things_to_do": [
        "Water Sports",
        "Nightlife",
        "Beach Camping"
    ]
}

}

HD_IMAGES = {
    "Mumbai": "https://images.unsplash.com/photo-1529253355930-ddbe423a2ac7",
    "Jaipur": "https://www.getyourguide.com/jaipur-l1149/jaipur-sightseeing-tour-by-classic-vintage-car-t1130133/?price=52290&referral_redirect=1",
    "New Delhi": "https://images.unsplash.com/photo-1587474260584-136574528ed5",
    "Goa": "https://images.unsplash.com/photo-1512343879784-a960bf40e7f2",
    "Bengaluru": "https://images.unsplash.com/photo-1596176530529-78163a4f7af2",
    "Varanasi": "https://images.unsplash.com/photo-1561361513-2d000a50f0dc",
    "Udaipur": "https://images.unsplash.com/photo-1615836245337-f5b9b2303f10",
    "Agra": "https://images.unsplash.com/photo-1564507592333-c60657eea523",
    "Kolkata": "https://images.unsplash.com/photo-1558431382-27e303142255",
    "Chennai": "https://images.unsplash.com/photo-1582510003544-4d00b7f74220",
}