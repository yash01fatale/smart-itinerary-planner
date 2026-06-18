const genAI = require("../config/gemini");

async function generateItinerary(data) {
  try {
    const model = genAI.getGenerativeModel({
      model: "gemini-2.5-flash",
    });

    const prompt = `
Generate a detailed travel itinerary.

Destination: ${data.destination}
Days: ${data.days}
Travelers: ${data.travelers}
Budget: ₹${data.budget}
Category: ${data.category}

Include:
1. Day wise itinerary
2. Places to visit
3. Estimated budget
4. Food recommendations
5. Travel tips
6. Safety precautions
`;

    const result =
      await model.generateContent(prompt);

    return result.response.text();

  } catch (error) {
    throw error;
  }
}

module.exports = {
  generateItinerary,
};