const destinations =
require("../data/destinations.json");

function recommend(input){

  return destinations
    .map(place=>{

      let score = 0;

      if(
        place.category ===
        input.category
      ){
        score += 50;
      }

      if(
        input.budget >=
        place.budgetMin &&
        input.budget <=
        place.budgetMax
      ){
        score += 30;
      }

      score +=
        20 -
        Math.abs(
          place.idealDays -
          input.days
        );

      return {
        ...place,
        score
      };

    })
    .sort(
      (a,b)=>
      b.score-a.score
    )
    .slice(0,5);
}

module.exports = recommend;