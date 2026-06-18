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
    "thumbnail": item.get("thumbnail", "")
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