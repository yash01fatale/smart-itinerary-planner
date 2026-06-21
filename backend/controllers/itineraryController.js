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

const {
 db
} =
require(
 "../config/firebase"
);

exports.generatePlan =
async (req,res)=>{

 try{

  const input =
  req.body;

  // Step 1: Get recommendations
  const recommendations =
  recommend(input);
  
  const selected =
  recommendations[0];

  // Step 2: Get place details
  const place =
  await getPlaceDetails(
    selected.name
  );

  // Step 3: Get weather
  const weather =
  await getWeather(
    selected.name
  );

  // Step 4: Generate itinerary
  const itinerary =
  await generateItinerary(
    input,
    place,
    weather
  );

  // Step 5: Save to Firebase
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

  // Step 6: Send response
  res.json({
   success: true,
   recommendation:
   selected,
   place,
   weather,
   itinerary,
   tripId: tripRef.id
  });

 }catch(error){

  res.status(500).json({
   success: false,
   error:error.message
  });

 }

};