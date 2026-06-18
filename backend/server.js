require("dotenv").config();

const express =
require("express");

const cors =
require("cors");

const recommendationRoutes =
require(
 "./routes/recommendationRoutes"
);

const app = express();
const itineraryRoutes =
require(
 "./routes/itineraryRoutes"
);

app.use(
 "/api/itinerary",
 itineraryRoutes
);
app.use(cors());

app.use(express.json());
const userRoutes =
require("./routes/userRoutes");

app.use(
 "/api/users",
 userRoutes
);
app.use(
 "/api/recommendations",
 recommendationRoutes
);

app.get("/",(req,res)=>{

  res.json({
    status:"Running"
  });

});

const PORT =
process.env.PORT || 5000;

app.listen(PORT,()=>{

  console.log(
   `Server Running On ${PORT}`
  );

});