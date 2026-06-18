const recommend =
require(
 "../services/recommendationEngine"
);

const {
 getPlaceDetails
} =
require(
 "../services/placesService"
);

const {
 getWeather
} =
require(
 "../services/weatherService"
);

const {
 generateItinerary
} =
require(
 "../services/geminiService"
);

exports.generatePlan =
async (req,res)=>{

 try{

  const input =
  req.body;

  const recommendations =
  recommend(input);
  const { db } =
require("../config/firebase");

const tripRef =
await db
.collection("trips")
.add({

 userId:
 input.userId,

 destination:
 selected.name,

 itinerary,

 weather,

 budget:
 input.budget,

 travelers:
 input.travelers,

 createdAt:
 new Date()

});
  const selected =
  recommendations[0];

  const place =
  await getPlaceDetails(
    selected.name
  );

  const weather =
  await getWeather(
    selected.name
  );

  const itinerary =
  await generateItinerary(
    input,
    place,
    weather
  );

  res.json({

    recommendation:
    selected,

    place,

    weather,

    itinerary

  });

 }catch(error){

  res.status(500).json({
   error:error.message
  });

 }

};