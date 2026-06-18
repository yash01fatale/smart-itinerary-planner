const axios =
require("axios");

async function getWeather(city) {

  try {

    const response =
      await axios.get(

      "https://api.openweathermap.org/data/2.5/weather",

      {
        params: {
          q: city,
          appid:
            process.env
             .OPENWEATHER_API_KEY,
          units: "metric",
        },
      }
    );

    return {
      temperature:
        response.data.main.temp,

      humidity:
        response.data.main.humidity,

      condition:
        response.data.weather[0]
          .description,
    };

  } catch (error) {

    return null;
  }
}

module.exports = {
  getWeather,
};