# Itinerary Screen - Visual Design Mockups

## Complete UI Layout Mockups

---

## 1. MOBILE VIEW (< 600dp)

### Portrait Orientation

```
┌─────────────────────────────────────┐
│ ↑                                   │  ← Status Bar
├─────────────────────────────────────┤
│  ← Goa                              │
│  ┌───────────────────────────────┐  │  ← Header (pinned)
│  │                               │  │     Destination name
│  │  [   Hero Image 250dp   ]     │  │
│  │  with gradient overlay        │  │
│  │  ┌─────────────────────────┐  │  │
│  │  │ Made from Unsplash API  │  │  │
│  │  └─────────────────────────┘  │  │
│  └───────────────────────────────┘  │
├─────────────────────────────────────┤
│                                     │
│ ┌─────── TRIP SUMMARY ────────────┐ │
│ │                                 │ │
│ │ ┌──────────────┐ ┌───────────┐ │ │
│ │ │   📅         │ │   👥       │ │ │
│ │ │  3 days      │ │  2 people  │ │ │
│ │ └──────────────┘ └───────────┘ │ │
│ │                                 │ │
│ │ ┌──────────────┐ ┌───────────┐ │ │
│ │ │   🏖️        │ │   💰       │ │ │
│ │ │   Beach      │ │ ₹50,000    │ │ │
│ │ └──────────────┘ └───────────┘ │ │
│ │                                 │ │
│ │ ████████░ ₹45K / ₹50K          │ │
│ │                                 │ │
│ └─────────────────────────────────┘ │
│                                     │
├─────────────────────────────────────┤
│  [Day 1]  [Day 2]  [Day 3]          │
│  selected ← scroll right            │
├─────────────────────────────────────┤
│                                     │
│  Day 1: Arrival & Beach             │
│  Est. Cost: ₹15,000                 │
│                                     │
│  ┌─────────────────────────────┐   │
│  │  14:00                      │   │  ← Activity Card
│  │  🏨 Hotel Check-in          │   │     1/4
│  │  Resort Goa Paradise        │   │
│  │  ⏱️ 60m  💰 ₹5,000          │   │
│  │  Early check-in available   │   │
│  └─────────────────────────────┘   │
│                                     │
│  ┌─────────────────────────────┐   │
│  │  16:00                      │   │  ← Activity Card
│  │  🏖️ Baga Beach Time          │   │     2/4
│  │  Baga Beach                 │   │
│  │  ⏱️ 120m  ⭐ 4.5  💰 Free    │   │
│  └─────────────────────────────┘   │
│                                     │
│  ┌─────────────────────────────┐   │
│  │  19:00                      │   │  ← Activity Card
│  │  🍽️ Dinner at Beach Shack    │   │     3/4
│  │  Tito's Beach Shack         │   │
│  │  ⏱️ 90m  💰 ₹3,000          │   │
│  └─────────────────────────────┘   │
│                                     │
├─────────────────────────────────────┤
│                                     │
│  ┌─────────────────────────────┐   │
│  │  💾 Save  |  📤 Share       │   │
│  └─────────────────────────────┘   │
│                                     │
└─────────────────────────────────────┘
```

### Activity Details Modal (Bottom Sheet)

```
┌─────────────────────────────────────┐
│         [════════════════]          │  ← Drag handle
├─────────────────────────────────────┤
│ Hotel Check-in              [✕]     │
│ Resort Goa Paradise                 │
│                                     │
├─────────────────────────────────────┤
│ 🕐 Time                              │
│ 14:00                                │
├─────────────────────────────────────┤
│ ⏱️  Duration                          │
│ 60 minutes                           │
├─────────────────────────────────────┤
│ 💰 Cost                              │
│ ₹5,000                               │
├─────────────────────────────────────┤
│ 📍 Location                          │
│ Baga Beach, North Goa 403516        │
├─────────────────────────────────────┤
│ ⭐ Rating                             │
│ 4.7 / 5.0                            │
├─────────────────────────────────────┤
│ 📝 Notes                              │
│ Early check-in available upon        │
│ request. Special welcome drink.      │
├─────────────────────────────────────┤
│ [🗺️ Directions]  [🔖 Save]           │
└─────────────────────────────────────┘
```

---

## 2. TABLET VIEW (600-1200dp)

### Landscape Orientation

```
┌────────────────────────────────────────────────────────────────────┐
│                                                                    │
│  ← Goa                                           [════════════════]│
│  ┌──────────────────────────────────────────────────────────────┐ │
│  │                                                              │ │
│  │         [   Hero Image 280dp height   ]                      │ │
│  │         with gradient overlay                               │ │
│  │         ┌─────────────────────────────────────────────────┐ │ │
│  │         │            Goa - Beach Paradise               │ │ │
│  │         └─────────────────────────────────────────────────┘ │ │
│  └──────────────────────────────────────────────────────────────┘ │
│                                                                    │
├────────────────────────────────────────────────────────────────────┤
│                                                                    │
│ ┌─ TRIP SUMMARY ──────────────────────────────────────────────┐  │
│ │                                                              │  │
│ │  ┌──────────┐  ┌──────────┐  ┌──────────┐  ┌──────────┐    │  │
│ │  │   📅      │  │   👥      │  │   🏖️      │  │   💰      │    │  │
│ │  │ 3 days    │  │ 2 people   │  │ Beach    │  │ ₹50,000   │    │  │
│ │  └──────────┘  └──────────┘  └──────────┘  └──────────┘    │  │
│ │                                                              │  │
│ │  ████████░ ₹45K / ₹50K                                      │  │
│ │                                                              │  │
│ └──────────────────────────────────────────────────────────────┘  │
│                                                                    │
├────────────────────────────────────────────────────────────────────┤
│                                                                    │
│ [Day 1 ✓]  [Day 2]  [Day 3]  (horizontally scrollable)            │
│                                                                    │
├────────────────────────────────────────────────────────────────────┤
│                                                                    │
│ Day 1: Arrival & Beach Exploration                               │
│ Est. Cost: ₹15,000                                                │
│                                                                    │
│ ┌──────────────────────────────┐  ┌──────────────────────────────┐│
│ │ 14:00                        │  │ 16:00                        ││
│ │ 🏨 Hotel Check-in            │  │ 🏖️ Baga Beach Time           ││
│ │ Resort Goa Paradise          │  │ Baga Beach                   ││
│ │ ⏱️ 60m | 💰 ₹5,000           │  │ ⏱️ 120m | ⭐ 4.5 | 💰 Free   ││
│ │ Early check-in available     │  │ Best sunset: 6:30 PM         ││
│ └──────────────────────────────┘  └──────────────────────────────┘│
│                                                                    │
│ ┌──────────────────────────────┐                                   │
│ │ 19:00                        │                                   │
│ │ 🍽️ Dinner at Beach Shack      │                                   │
│ │ Tito's Beach Shack           │                                   │
│ │ ⏱️ 90m | 💰 ₹3,000           │                                   │
│ │ Vegetarian options available │                                   │
│ └──────────────────────────────┘                                   │
│                                                                    │
│ ┌──────────────────────────────────────────────────────────────┐  │
│ │ [💾 Save Itinerary]       [📤 Share Trip]                    │  │
│ └──────────────────────────────────────────────────────────────┘  │
│                                                                    │
└────────────────────────────────────────────────────────────────────┘
```

---

## 3. DESKTOP VIEW (> 1200dp)

### Full Width Layout

```
┌────────────────────────────────────────────────────────────────────────────────┐
│                                                                                │
│  Goa                                                    [══════════════════]   │
│  ┌──────────────────────────────────────────────────────────────────────────┐ │
│  │                                                                          │ │
│  │              [   Hero Image 320dp height with overlay   ]                │ │
│  │              ┌──────────────────────────────────────────────────────┐   │ │
│  │              │         Goa - Beach Paradise Travel Guide          │   │ │
│  │              │              3 Days, 2 Travelers                    │   │ │
│  │              └──────────────────────────────────────────────────────┘   │ │
│  └──────────────────────────────────────────────────────────────────────────┘ │
│                                                                                │
├────────────────────────────────────────────────────────────────────────────────┤
│                                                                                │
│ ┌─ TRIP SUMMARY ──────────────────────────────────────────────────────────────┐│
│ │                                                                              ││
│ │ ┌──────────────┐  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐    ││
│ │ │    📅        │  │    👥         │  │    🏖️        │  │    💰        │    ││
│ │ │  3 Days      │  │  2 Travelers  │  │  Beach       │  │  ₹50,000     │    ││
│ │ │  Jun 20-22   │  │  Total        │  │  Category    │  │  Per Day     │    ││
│ │ │              │  │               │  │              │  │  ₹16,666     │    ││
│ │ └──────────────┘  └──────────────┘  └──────────────┘  └──────────────┘    ││
│ │                                                                              ││
│ │  Estimated Cost: ₹45,000  |  Budget: ₹50,000  |  Remaining: ₹5,000         ││
│ │  ████████░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░       ││
│ │  90% utilized                                                                ││
│ │                                                                              ││
│ └──────────────────────────────────────────────────────────────────────────────┘│
│                                                                                │
├────────────────────────────────────────────────────────────────────────────────┤
│                                                                                │
│ SELECT DAY: [Day 1 ✓] [Day 2] [Day 3]                                          │
│                                                                                │
├────────────────────────────────────────────────────────────────────────────────┤
│                                                                                │
│ DAY 1: ARRIVAL & BEACH EXPLORATION                  Est. Cost: ₹15,000        │
│ Optional notes and tips for the day can appear here if provided               │
│                                                                                │
├──────────────────────────────────────────────────────────────────────────────┤
│                                                                                │
│ ┌─────────────────────────────────┐  ┌─────────────────────────────────────┐ │
│ │  14:00                          │  │  16:00                              │ │
│ │  🏨 Hotel Check-in              │  │  🏖️ Baga Beach Time                 │ │
│ │  Resort Goa Paradise            │  │  Baga Beach                         │ │
│ │                                 │  │                                     │ │
│ │  Location: Baga Beach, N Goa    │  │  Location: Baga, N Goa              │ │
│ │  ⏱️ 60 minutes                   │  │  ⏱️ 120 minutes                     │ │
│ │  💰 ₹5,000                       │  │  💰 Free Entry                       │ │
│ │  ⭐ 4.7/5.0 (324 reviews)       │  │  ⭐ 4.5/5.0 (1,245 reviews)        │ │
│ │                                 │  │                                     │ │
│ │  🔖 Early check-in available    │  │  📝 Best sunset at 6:30 PM          │ │
│ │     upon request. Complimentary │  │     Avoid afternoon heat 2-4 PM     │ │
│ │     welcome drink in lobby.     │  │                                     │ │
│ │                                 │  │                                     │ │
│ │  [🗺️ Directions] [🔖 Save]       │  │  [🗺️ Directions] [🔖 Save]         │ │
│ └─────────────────────────────────┘  └─────────────────────────────────────┘ │
│                                                                                │
│ ┌─────────────────────────────────┐                                            │
│ │  19:00                          │                                            │
│ │  🍽️ Dinner at Beach Shack       │                                            │
│ │  Tito's Beach Shack             │                                            │
│ │                                 │                                            │
│ │  Location: Baga Beach Road, Goa │                                            │
│ │  ⏱️ 90 minutes                   │                                            │
│ │  💰 ₹3,000                       │                                            │
│ │  ⭐ 4.4/5.0 (587 reviews)       │                                            │
│ │                                 │                                            │
│ │  🔖 Vegetarian and non-veg       │                                            │
│ │     options available. Try the   │                                            │
│ │     seafood speciality!          │                                            │
│ │                                 │                                            │
│ │  [🗺️ Directions] [🔖 Save]       │                                            │
│ └─────────────────────────────────┘                                            │
│                                                                                │
├────────────────────────────────────────────────────────────────────────────────┤
│                                                                                │
│  [💾 Save Itinerary]         [📤 Share with Friends]         [✎ Edit Plan]     │
│                                                                                │
└────────────────────────────────────────────────────────────────────────────────┘
```

---

## 4. Activity Card Detail View

### Expanded Activity Card (Tap to Expand)

```
Before Tap (Compact):
┌────────────────────────────┐
│ 14:00 │ Hotel Check-in     │
│       │ Resort Goa         │
│       │ ⏱️ 60m | 💰 ₹5,000 │
└────────────────────────────┘

After Tap (Bottom Sheet Modal):
┌────────────────────────────────────┐
│        [════════════════]          │
├────────────────────────────────────┤
│ Hotel Check-in                [✕] │
│ Resort Goa Paradise                │
│                                    │
├────────────────────────────────────┤
│ 🕐 Time                            │
│ 14:00 - 15:00                      │
├────────────────────────────────────┤
│ ⏱️ Duration                        │
│ 60 minutes                         │
├────────────────────────────────────┤
│ 💰 Cost                            │
│ ₹5,000 per person                  │
├────────────────────────────────────┤
│ 📍 Location                        │
│ Baga Beach, North Goa 403516      │
│ Tap for directions ↗️              │
├────────────────────────────────────┤
│ ⭐ Rating                          │
│ 4.7 / 5.0  (324 reviews)          │
├────────────────────────────────────┤
│ 🏷️ Category                        │
│ Accommodation                      │
├────────────────────────────────────┤
│ 📝 Notes & Tips                    │
│ Early check-in available upon      │
│ request. Complimentary welcome     │
│ drink. Concierge available 24/7.   │
├────────────────────────────────────┤
│ [🗺️ Get Directions]                │
│ [🔖 Save for Later]                │
│ [📤 Share]                         │
└────────────────────────────────────┘
```

---

## 5. Color Palette Reference

### Activity Category Colors

```
🏨 Accommodation/Hotel
   Background: #EDE9FE (Indigo-50)
   Text: #4338CA (Indigo-600)
   Icon: #818CF8 (Indigo-400)

🏖️ Beach
   Background: #CFFAFE (Cyan-50)
   Text: #0891B2 (Cyan-700)
   Icon: #06B6D4 (Cyan-500)

🍽️ Restaurant/Dining
   Background: #FED7AA (Orange-50)
   Text: #EA580C (Orange-600)
   Icon: #FB923C (Orange-400)

🎨 Museum/Art
   Background: #E9D5FF (Purple-50)
   Text: #7C3AED (Purple-600)
   Icon: #A78BFA (Purple-400)

⛰️ Adventure
   Background: #FEE2E2 (Red-50)
   Text: #DC2626 (Red-600)
   Icon: #F87171 (Red-400)

🏛️ Monument/Historical
   Background: #FEFCE8 (Brown-50)
   Text: #92400E (Brown-700)
   Icon: #D97706 (Brown-500)

🌳 Park
   Background: #DCFCE7 (Green-50)
   Text: #15803D (Green-700)
   Icon: #22C55E (Green-500)

🚗 Transport
   Background: #DBEAFE (Blue-50)
   Text: #1D4ED8 (Blue-600)
   Icon: #3B82F6 (Blue-400)

🛍️ Shopping
   Background: #FCE7F3 (Pink-50)
   Text: #BE185D (Pink-700)
   Icon: #EC4899 (Pink-500)
```

---

## 6. Responsive Breakpoints

### Navigation Pattern

```
Mobile (<600dp):
  Single Column
  └─ Header (250dp)
  └─ Summary (compact)
  └─ Day Tabs (horizontal scroll)
  └─ Activity Cards (full width)

Tablet (600-1200dp):
  Flexible Layout
  └─ Header (280dp)
  └─ Summary (expanded)
  └─ Day Tabs + Content (side by side option)
  └─ Activity Cards (2 columns)

Desktop (>1200dp):
  Three Column Layout
  └─ Header (320dp)
  └─ Summary (full width)
  └─ Left Sidebar: Days
  └─ Center: Activities
  └─ Right Sidebar: Details
```

---

## 7. Animation Guidelines

### Smooth Transitions

```
Day Tab Selection:
   Duration: 300ms
   Curve: EaseInOut
   Action: Scroll to day + Update activities

Activity Card Tap:
   Duration: 200ms
   Curve: EaseOut
   Action: Show bottom sheet with slide-up animation

Image Loading:
   Duration: 500ms
   Curve: Linear
   Action: Fade in from placeholder

Cost Progress Bar:
   Duration: 1500ms
   Curve: EaseInOut
   Action: Animate fill on screen load
```

---

## 8. Typography Scale

```
Display: 32pt, bold, #1F2937
Headline: 28pt, bold, #1F2937
Title Large: 22pt, bold, #1F2937
Title Medium: 18pt, semibold, #1F2937
Title Small: 16pt, semibold, #1F2937

Body: 14pt, regular, #1F2937
Body Small: 13pt, regular, #374151
Label: 12pt, medium, #4B5563
Label Small: 11pt, medium, #6B7280

Code: 13pt, monospace, #1F2937
```

---

## 9. Spacing Grid

```
Base Unit: 4dp

Used Multiples:
- 4dp   (1x)   - Small gaps
- 8dp   (2x)   - Compact spacing
- 12dp  (3x)   - Standard spacing
- 16dp  (4x)   - Card padding
- 20dp  (5x)   - Section spacing
- 24dp  (6x)   - Large spacing
- 32dp  (8x)   - Extra large spacing

Examples:
- Card margin: 12dp
- Card padding: 16dp
- Section spacing: 20dp
- Element gap: 8dp
```

---

**Status**: ✅ Visual Design Complete
**Format**: ASCII Art with measurements
**Version**: 1.0
**Updated**: June 20, 2024
