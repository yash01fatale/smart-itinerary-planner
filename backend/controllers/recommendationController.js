const recommend =
require(
 "../services/recommendationEngine"
);

exports.getRecommendations =
async(req,res)=>{

  try{

    const result =
    recommend(req.body);

    res.status(200).json(result);

  }catch(error){

    res.status(500).json({
      error:error.message
    });

  }
};