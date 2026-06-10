from fastapi import FastAPI
from serpapi import GoogleSearch
import os

app = FastAPI()

SERPAPI_KEY = os.getenv("SERPAPI_KEY")

@app.get("/destinations")
def get_destinations(country: str):

    search = GoogleSearch({
        "engine": "google",
        "q": f"{country} destinations",
        "api_key": SERPAPI_KEY
    })

    results = search.get_dict()

    return {
        "results": results.get("organic_results", [])
    }