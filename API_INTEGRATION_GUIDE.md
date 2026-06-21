# API Integration Guide - Enhanced Itinerary Response

## Overview
This guide explains how to integrate the enhanced itinerary screen with your backend API. The new implementation supports both legacy and enhanced response formats.

---

## Current API Endpoint

```
POST /generate-itinerary
Host: http://192.168.1.100:8000
Content-Type: application/json
```

### Request Format
```json
{
  "destination": "Goa",
  "category": "Beach",
  "travelers": 2,
  "budget": 50000,
  "days": 3
}
```

---

## Response Format Compatibility

### Option 1: Legacy Format (Current - Still Works ✅)

**Request:**
```bash
curl -X POST http://192.168.1.100:8000/generate-itinerary \
  -H "Content-Type: application/json" \
  -d '{
    "destination": "Goa",
    "category": "Beach",
    "travelers": 2,
    "budget": 50000,
    "days": 3
  }'
```

**Response:**
```json
{
  "destination": "Goa",
  "budget": 50000,
  "days": 3,
  "itinerary": [
    {
      "day": 1,
      "places": ["Baga Beach", "Restaurant", "Fort Aguada"]
    },
    {
      "day": 2,
      "places": ["Colva Beach", "Spice Farm", "Casino"]
    },
    {
      "day": 3,
      "places": ["Shopping", "Water Sports", "Departure"]
    }
  ]
}
```

**Frontend Auto-Conversion:**
- ✅ Automatically converts to new Activity model
- ✅ Generates sequential time slots (9:00, 12:00, 15:00, etc.)
- ✅ Estimates 2-hour duration per activity
- ✅ No breaking changes
- ✅ No code changes needed in Flutter

---

### Option 2: Enhanced Format (Recommended 🚀)

**Response with Rich Activity Data:**

```json
{
  "destination": "Goa",
  "budget": 50000,
  "days": 3,
  "travelers": 2,
  "category": "Beach",
  "itinerary": [
    {
      "day": 1,
      "date": "2024-06-20",
      "title": "Arrival & Beach Exploration",
      "estimated_cost": 15000,
      "notes": "Day of arrival with beach time in evening",
      "activities": [
        {
          "time": "14:00",
          "title": "Hotel Check-in",
          "duration": 60,
          "cost": 5000,
          "notes": "Early check-in available upon request",
          "place": {
            "name": "Resort Goa Paradise",
            "category": "accommodation",
            "description": "5-star beachfront resort with excellent service",
            "address": "Baga Beach, North Goa 403516",
            "rating": 4.7,
            "review_count": 324,
            "image_url": "https://images.unsplash.com/photo-1507525428034-b723cf961d3e"
          }
        },
        {
          "time": "16:00",
          "title": "Baga Beach Time",
          "duration": 120,
          "cost": 0,
          "notes": "Best sunset time: 6:30 PM. Avoid 2-4 PM heat",
          "place": {
            "name": "Baga Beach",
            "category": "beach",
            "description": "Popular beach with water sports and beach shacks",
            "address": "Baga, North Goa 403516",
            "rating": 4.5,
            "review_count": 1245,
            "image_url": "https://images.unsplash.com/photo-1507525428034-b723cf961d3e"
          }
        },
        {
          "time": "19:00",
          "title": "Dinner at Beach Shack",
          "duration": 90,
          "cost": 3000,
          "notes": "Vegetarian and non-vegetarian options available",
          "place": {
            "name": "Tito's Beach Shack",
            "category": "restaurant",
            "description": "Popular beachside restaurant with seafood specialities",
            "address": "Baga Beach Road, North Goa 403516",
            "rating": 4.4,
            "review_count": 587,
            "image_url": "https://images.unsplash.com/photo-1517248135467-4d71bcdd2d59"
          }
        }
      ]
    },
    {
      "day": 2,
      "date": "2024-06-21",
      "title": "Local Culture & Adventure",
      "estimated_cost": 18000,
      "notes": "Mix of adventure activities and cultural exploration",
      "activities": [
        {
          "time": "09:00",
          "title": "Breakfast at Local Cafe",
          "duration": 60,
          "cost": 800,
          "notes": "Try the local Goan breakfast - poori and curry",
          "place": {
            "name": "Cafe Goa",
            "category": "restaurant",
            "description": "Traditional Goan breakfast spot",
            "address": "Anjuna Market Road, Goa",
            "rating": 4.2,
            "review_count": 234
          }
        },
        {
          "time": "11:00",
          "title": "Water Sports",
          "duration": 180,
          "cost": 7000,
          "notes": "Jet ski, parasailing, or banana boat available",
          "place": {
            "name": "Water Sports Arena - Baga",
            "category": "adventure",
            "description": "Full range of water sports activities",
            "address": "Baga Beach",
            "rating": 4.6,
            "review_count": 456
          }
        },
        {
          "time": "15:00",
          "title": "Spice Farm Tour",
          "duration": 120,
          "cost": 2500,
          "notes": "Learn about spices, plantation tour included",
          "place": {
            "name": "Anjuna Spice Farm",
            "category": "attraction",
            "description": "Traditional spice plantation with guided tours",
            "address": "Anjuna, North Goa",
            "rating": 4.3,
            "review_count": 312
          }
        },
        {
          "time": "18:00",
          "title": "Sunset at Fort Aguada",
          "duration": 90,
          "cost": 0,
          "notes": "Best photography spot. Go 30 min before sunset",
          "place": {
            "name": "Fort Aguada",
            "category": "monument",
            "description": "Historic Portuguese fort with panoramic views",
            "address": "Fort Aguada, Goa",
            "rating": 4.5,
            "review_count": 890
          }
        }
      ]
    },
    {
      "day": 3,
      "date": "2024-06-22",
      "title": "Shopping & Departure",
      "estimated_cost": 17000,
      "notes": "Last day for souvenirs before departure",
      "activities": [
        {
          "time": "09:00",
          "title": "Morning Shopping at Anjuna Market",
          "duration": 180,
          "cost": 5000,
          "notes": "Open Wed & Sat. Friday market also available",
          "place": {
            "name": "Anjuna Market",
            "category": "shopping",
            "description": "Famous flea market with local crafts and souvenirs",
            "address": "Anjuna, North Goa",
            "rating": 4.2,
            "review_count": 678
          }
        },
        {
          "time": "13:00",
          "title": "Lunch at Local Restaurant",
          "duration": 90,
          "cost": 2000,
          "notes": "Enjoy last meal before departure",
          "place": {
            "name": "The Pepper House",
            "category": "restaurant",
            "description": "Multi-cuisine restaurant with Goan specialties",
            "address": "Calangute, Goa",
            "rating": 4.3,
            "review_count": 425
          }
        },
        {
          "time": "15:00",
          "title": "Departure from Hotel",
          "duration": 60,
          "cost": 10000,
          "notes": "Check-out time: 12:00 PM. Late checkout available",
          "place": {
            "name": "Resort Goa Paradise",
            "category": "accommodation",
            "description": "Return to hotel for departure",
            "address": "Baga Beach, North Goa",
            "rating": 4.7,
            "review_count": 324
          }
        }
      ]
    }
  ]
}
```

---

## Backend Implementation

### Python/FastAPI Enhanced Endpoint

```python
from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
from typing import List
from datetime import datetime, timedelta

app = FastAPI()

class Place(BaseModel):
    name: str
    category: str
    description: str
    address: str
    rating: float = 4.0
    review_count: int = 0
    image_url: Optional[str] = None

class Activity(BaseModel):
    time: str
    title: str
    duration: int  # minutes
    cost: float = 0.0
    notes: str = ""
    place: Place

class ItineraryDay(BaseModel):
    day: int
    date: str
    title: str
    estimated_cost: float
    notes: str = ""
    activities: List[Activity]

class TripRequest(BaseModel):
    destination: str
    category: str
    budget: int
    travelers: int
    days: int

class ItineraryResponse(BaseModel):
    destination: str
    budget: int
    days: int
    travelers: int
    category: str
    itinerary: List[ItineraryDay]

@app.post("/generate-itinerary", response_model=ItineraryResponse)
async def generate_itinerary(request: TripRequest):
    """
    Generate enhanced itinerary with detailed activities
    """
    try:
        # Your existing place data fetching logic
        raw_places = get_places(request.destination)
        places = extract_and_rank_places(raw_places)
        
        # Generate activities for each day
        itinerary_days = []
        places_per_day = len(places) // request.days
        
        start_date = datetime.now()
        
        for day_num in range(1, request.days + 1):
            current_date = start_date + timedelta(days=day_num - 1)
            
            # Get places for this day
            day_places = places[
                (day_num - 1) * places_per_day : day_num * places_per_day
            ]
            
            # Convert places to activities with scheduled times
            activities = generate_day_activities(
                day_places, 
                day_num,
                request.travelers,
                request.budget / request.days
            )
            
            day_cost = sum(activity.cost for activity in activities)
            
            day = ItineraryDay(
                day=day_num,
                date=current_date.strftime("%Y-%m-%d"),
                title=generate_day_title(day_num, request.category),
                estimated_cost=day_cost,
                notes=generate_day_notes(day_num, day_places),
                activities=activities
            )
            
            itinerary_days.append(day)
        
        return ItineraryResponse(
            destination=request.destination,
            budget=request.budget,
            days=request.days,
            travelers=request.travelers,
            category=request.category,
            itinerary=itinerary_days
        )
    
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))

def generate_day_activities(places, day_num, travelers, daily_budget):
    """Generate activities with times for a day"""
    activities = []
    start_hour = 9
    
    for idx, place in enumerate(places):
        hour = start_hour + (idx * 3)
        
        activity = Activity(
            time=f"{hour:02d}:00",
            title=place.get("activity_title", place["name"]),
            duration=place.get("duration", 120),
            cost=place.get("cost", 0),
            notes=place.get("notes", ""),
            place=Place(
                name=place["name"],
                category=place.get("category", "attraction"),
                description=place.get("description", ""),
                address=place.get("address", ""),
                rating=place.get("rating", 4.0),
                review_count=place.get("review_count", 0),
                image_url=place.get("image_url")
            )
        )
        
        activities.append(activity)
    
    return activities

def generate_day_title(day_num, category):
    """Generate descriptive day title based on category"""
    titles = {
        "Beach": [
            "Arrival & Beach Exploration",
            "Water Sports & Relaxation",
            "Local Culture & Beach Time"
        ],
        "Mountain": [
            "Arrival & Trek Preparation",
            "Mountain Adventure",
            "Descent & Exploration"
        ],
        "Historical": [
            "Arrival & Historic Tour",
            "Monument Exploration",
            "Cultural Immersion"
        ],
        # Add more categories...
    }
    
    category_titles = titles.get(category, ["Day 1", "Day 2", "Day 3"])
    return category_titles[min(day_num - 1, len(category_titles) - 1)]

def generate_day_notes(day_num, places):
    """Generate helpful notes for the day"""
    if day_num == 1:
        return "Day of arrival. Light activities recommended."
    elif day_num > 1:
        return f"Full day of exploration and activities."
    else:
        return "Last day. Consider checkout and travel times."
```

---

## Migration Strategy

### Step 1: Verify Current Format Works
```dart
// Your existing code still works:
final response = await ItineraryApi.generateItinerary(
  destination: "Goa",
  category: "Beach",
  travelers: 2,
  budget: 50000,
  days: 3,
);

// Auto-converts legacy format to new model
print(response.itinerary[0].activities.length);  // Works fine!
```

### Step 2: Update Backend (Optional)
```python
# Update /generate-itinerary to return enhanced format
# No frontend changes needed - it still works!
```

### Step 3: Progressive Enhancement
```dart
// Your UI automatically gets better as backend provides more data
// Old format: Simple activity list
// New format: Rich activity details

// Same code works for both!
```

---

## Data Mapping Examples

### Example 1: Legacy to Enhanced

**API Response (Legacy):**
```json
{
  "destination": "Goa",
  "budget": 50000,
  "days": 1,
  "itinerary": [
    {
      "day": 1,
      "places": ["Baga Beach", "Restaurant"]
    }
  ]
}
```

**Converted to (New Model):**
```json
{
  "destination": "Goa",
  "budget": 50000,
  "days": 1,
  "travelers": 1,
  "category": "General",
  "itinerary": [
    {
      "day": 1,
      "date": "",
      "title": "Day 1",
      "estimated_cost": 0,
      "activities": [
        {
          "time": "09:00",
          "title": "Baga Beach",
          "duration": 120,
          "place": {
            "name": "Baga Beach",
            "category": "attraction",
            "rating": 4.0,
            ...
          },
          "cost": 0,
          "notes": ""
        },
        {
          "time": "12:00",
          "title": "Restaurant",
          "duration": 120,
          ...
        }
      ]
    }
  ]
}
```

---

## Testing Examples

### Test 1: Legacy Format
```dart
test('Parse legacy itinerary format', () {
  final json = {
    "destination": "Goa",
    "budget": 50000,
    "days": 3,
    "itinerary": [
      {
        "day": 1,
        "places": ["Beach", "Restaurant", "Market"]
      }
    ]
  };
  
  final response = ItineraryResponse.fromJson(json);
  
  expect(response.destination, "Goa");
  expect(response.itinerary[0].activities.length, 3);
  expect(response.itinerary[0].activities[0].place.name, "Beach");
});
```

### Test 2: Enhanced Format
```dart
test('Parse enhanced itinerary format', () {
  final json = {
    "destination": "Goa",
    "budget": 50000,
    "days": 1,
    "travelers": 2,
    "category": "Beach",
    "itinerary": [
      {
        "day": 1,
        "date": "2024-06-20",
        "title": "Beach Day",
        "estimated_cost": 5000,
        "activities": [
          {
            "time": "09:00",
            "title": "Beach Time",
            "duration": 120,
            "cost": 0,
            "place": {
              "name": "Baga Beach",
              "category": "beach",
              "rating": 4.5,
              "address": "Baga, Goa"
            }
          }
        ]
      }
    ]
  };
  
  final response = ItineraryResponse.fromJson(json);
  
  expect(response.destination, "Goa");
  expect(response.travelers, 2);
  expect(response.category, "Beach");
  expect(response.itinerary[0].activities[0].time, "09:00");
});
```

---

## Performance Considerations

### API Response Size
| Format | Size | Notes |
|--------|------|-------|
| Legacy | ~2 KB | Places as strings |
| Enhanced | ~15 KB | Full details per activity |
| Compressed | ~3-5 KB | With gzip compression |

**Recommendation:** Use gzip compression in production
```python
from fastapi.middleware.gzip import GZIPMiddleware
app.add_middleware(GZIPMiddleware, minimum_size=1000)
```

---

## Error Handling

### Common Scenarios

**Scenario 1: Incomplete Activity Data**
```dart
// App handles missing fields gracefully
Activity(
  time: json["time"] ?? "09:00",
  title: json["title"] ?? "Activity",
  duration: json["duration"] ?? 60,
  place: Place.fromJson(json["place"] ?? {}),
  cost: (json["cost"] ?? 0).toDouble(),
  notes: json["notes"] ?? "",
)
```

**Scenario 2: Invalid Response**
```dart
try {
  final response = await ItineraryApi.generateItinerary(...);
  // Use response
} on FormatException catch (e) {
  print("Invalid response format: $e");
  // Show error to user
} on Exception catch (e) {
  print("API error: $e");
  // Show generic error message
}
```

---

## Deployment Checklist

- [ ] Test with legacy API response format
- [ ] Test with enhanced API response format
- [ ] Verify backward compatibility
- [ ] Test on different devices (mobile, tablet, desktop)
- [ ] Test with poor network conditions
- [ ] Test error scenarios
- [ ] Performance testing with large itineraries
- [ ] Accessibility testing
- [ ] User acceptance testing

---

## Support & Questions

**For technical support:**
1. Check the design document: `ITINERARY_DESIGN_DOCUMENT.md`
2. Review implementation summary: `IMPLEMENTATION_SUMMARY.md`
3. Compare old vs new: `DESIGN_COMPARISON.md`
4. Check API examples in this guide

---

**Status**: ✅ API Guide Complete  
**Version**: 1.0  
**Last Updated**: June 20, 2024
