const axios = require("axios");

async function getPlaceDetails(destination) {

  try {

    const url =
      "https://maps.googleapis.com/maps/api/place/textsearch/json";

    const response =
      await axios.get(url, {
        params: {
          query: destination,
          key:
            process.env
              .GOOGLE_PLACES_API_KEY,
        },
      });

    const place =
      response.data.results[0];

    return {
      name: place.name,
      address:
        place.formatted_address,
      rating:
        place.rating || 0,
      location:
        place.geometry.location,
      photoReference:
        place.photos?.[0]
          ?.photo_reference ||
        null,
    };

  } catch (error) {

    console.log(error);

    return null;
  }
}

module.exports = {
  getPlaceDetails,
};