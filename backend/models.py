import math


def rank_attractions(attractions):

    return sorted(
        attractions,
        key=lambda x: (
            x["rating"],
            x["reviews"]
        ),
        reverse=True
    )



def generate_daywise_itinerary(
    attractions,
    days
):

    ranked = rank_attractions(
        attractions
    )

    itinerary = []

    places_per_day = math.ceil(
        len(ranked) / days
    )

    index = 0

    for day in range(days):

        day_places = ranked[
            index:index + places_per_day
        ]

        itinerary.append({
            "day": day + 1,
            "places": day_places
        })

        index += places_per_day

    return itinerary