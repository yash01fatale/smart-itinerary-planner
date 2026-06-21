# Smart Itinerary Planner - Itinerary Screen Design

## Overview
Enhanced itinerary screen for displaying day-by-day travel plans with beautiful UI, interactive components, and comprehensive trip information.

## Current Architecture

### Backend (FastAPI)
- **Endpoint**: `/generate-itinerary`
- **Input**: destination, category, budget, travelers, days
- **Output**: ItineraryResponse with destination and itinerary array

### Frontend Structure
```
Models: itinerary_model.dart
  - ItineraryResponse
Services: itinerary_api.dart
  - generateItinerary()
Screens: ItineraryScreen.dart
  - Main itinerary display
Widgets: itinerary_day_card.dart (empty - needs implementation)
```

## Enhanced Design Specification

### 1. Data Model Enhancement
**File**: `itinerary_model.dart`

Enhanced model should support:
```
ItineraryDay {
  - day: int
  - date: DateTime
  - title: string (e.g., "Local Exploration")
  - places: List<Place>
  - activities: List<Activity>
  - estimatedCost: double
  - notes: string
}

Place {
  - name: string
  - description: string
  - category: string (restaurant, attraction, museum, etc.)
  - rating: double
  - reviewCount: int
  - imageUrl: string
  - address: string
}

Activity {
  - time: TimeOfDay
  - title: string
  - duration: int (minutes)
  - place: Place
  - cost: double
  - notes: string
}
```

### 2. UI Components

#### Header Section
- **Destination Image**: Full-width hero image with gradient overlay
- **Destination Name**: Large bold text overlaid on image
- **Quick Stats**: Trip duration, total cost, number of travelers
- **Action Buttons**: Save, Share, Edit options

#### Trip Summary Card
- Total budget and estimated cost
- Number of days and travelers
- Trip category
- Average daily budget
- Cost breakdown by category

#### Day Selection
- Horizontal scrollable day tabs or vertical list
- Current day highlighted
- Day number, date, and title
- Visual indicator for day status (current, passed, upcoming)

#### Activity Cards
- Time slot (morning, afternoon, evening, night)
- Activity title and place name
- Duration and estimated cost
- Quick description
- Category icon
- Rating (if available)
- Action buttons (directions, save, details)

#### Additional Features
- Weather information for each day
- Restaurant recommendations
- Local events
- Emergency contacts
- Trip notes and itinerary export

### 3. Screen Layout

```
┌─────────────────────────────┐
│   Destination Header        │
│   - Hero image              │
│   - Destination name        │
│   - Trip stats              │
├─────────────────────────────┤
│   Trip Summary Card         │
│   - Budget info             │
│   - Cost breakdown          │
├─────────────────────────────┤
│   Day Tabs/List             │
│   - Scrollable day selector │
├─────────────────────────────┤
│   Activities for Selected   │
│   Day                       │
│   - Morning activities      │
│   - Afternoon activities    │
│   - Evening activities      │
├─────────────────────────────┤
│   Action Buttons            │
│   - Save, Share, Edit       │
└─────────────────────────────┘
```

### 4. Visual Design

#### Colors
- **Primary**: Teal (#14B8A6)
- **Secondary**: Cyan (#06B6D4)
- **Background**: Light gray (#F8FAFC)
- **Card**: White (#FFFFFF)
- **Text**: Dark gray (#1F2937)
- **Accent**: Orange (#FB923C) for highlights

#### Typography
- **Destination**: 28pt bold
- **Day Title**: 20pt bold
- **Activity Title**: 16pt semibold
- **Body Text**: 14pt regular
- **Caption**: 12pt regular

#### Icons
- Time: `Icons.access_time`
- Location: `Icons.location_on`
- Cost: `Icons.attach_money`
- Rating: `Icons.star`
- Duration: `Icons.schedule`

### 5. Interactions

#### Gestures
- Swipe left/right between days
- Tap on activity for details
- Tap on place for map/directions
- Tap actions for save/share/edit

#### Navigation
- Bottom navigation to other screens
- Back button to previous screen
- Deep linking to specific day

#### States
- Loading: Skeleton loader during API call
- Empty: Message if no itinerary generated
- Error: Error message with retry button
- Loaded: Full itinerary display

### 6. Responsive Design

#### Mobile (< 600dp)
- Full-width hero image (250dp height)
- Vertical layout for all sections
- Single column for day selection
- Compact cards

#### Tablet (600dp - 1200dp)
- Two-column layout option
- Side panel for day selection
- Larger cards with more details
- Expanded statistics

#### Desktop (> 1200dp)
- Three-column layout
- Left sidebar for navigation
- Main content area
- Right sidebar for details

## Implementation Priority

1. **Phase 1**: Enhanced itinerary_model.dart with detailed activity data
2. **Phase 2**: itinerary_day_card.dart widget for individual activities
3. **Phase 3**: Redesigned ItineraryScreen.dart with new layout
4. **Phase 4**: Add interactive features (save, share, edit)
5. **Phase 5**: Weather and local recommendations integration

## Backend Enhancements

### Enhanced `/generate-itinerary` Response

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
      "estimatedCost": 15000,
      "activities": [
        {
          "time": "14:00",
          "title": "Arrival and Check-in",
          "duration": 60,
          "place": {
            "name": "Hotel Paradise",
            "category": "accommodation",
            "address": "Baga Beach, Goa"
          },
          "cost": 5000,
          "notes": "Early check-in available"
        },
        {
          "time": "16:00",
          "title": "Beach Time at Baga Beach",
          "duration": 120,
          "place": {
            "name": "Baga Beach",
            "category": "beach",
            "rating": 4.5,
            "address": "Baga, Goa",
            "imageUrl": "https://..."
          },
          "cost": 0,
          "notes": "Best sunset time: 6:30 PM"
        }
      ]
    }
  ]
}
```

## Testing Scenarios

1. **Minimal Trip**: 1 day, 1 person, 5000 budget
2. **Standard Trip**: 3 days, 2 people, 50000 budget
3. **Extended Trip**: 7 days, 4 people, 200000 budget
4. **Edge Cases**: Long activity duration, high number of activities per day

## Performance Considerations

- Lazy load images with placeholder
- Cache itinerary data locally
- Optimize list rendering with `const` constructors
- Use `PageView` for smooth day transitions
- Implement pagination if activities exceed 10 per day

## Accessibility

- Color contrast WCAG AA compliant
- Large touch targets (48x48dp minimum)
- Semantic labels for screen readers
- Alternative text for images
- Support for text scaling up to 200%

---

**Status**: Design Document Ready for Implementation
**Version**: 1.0
**Last Updated**: 2024-06-20
