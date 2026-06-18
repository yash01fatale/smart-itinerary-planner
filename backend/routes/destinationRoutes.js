// routes/destinationRoutes.js

const express = require('express');
const axios = require('axios');
const router = express.Router();

router.get('/popular-destinations', async (req, res) => {
  try {
    const query = req.query.q || 'India destinations';

    const response = await axios.get(
      'https://serpapi.com/search.json',
      {
        params: {
          engine: 'google',
          q: query,
          api_key: process.env.SERPAPI_KEY,
        },
      }
    );

    res.json(response.data);
  } catch (error) {
    res.status(500).json({
      error: error.message,
    });
  }
});

module.exports = router;