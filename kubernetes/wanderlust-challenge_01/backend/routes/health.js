import { Router } from 'express';
import mongoose from 'mongoose';
import { createClient } from 'redis';

const router = Router();

router.get('/', async (req, res) => {
  try {
    // check MongoDB connection
    const mongoStatus = mongoose.connection.readyState === 1;
    
    // check Redis connection
    const redisClient = createClient({
      url: process.env.REDIS_URL
    });
    await redisClient.connect();
    const redisStatus = redisClient.isOpen;
    await redisClient.disconnect();

    if (!mongoStatus || !redisStatus) {
      throw new Error('Services not ready');
    }

    res.status(200).json({
      status: 'healthy',
      services: {
        mongodb: mongoStatus ? 'connected' : 'disconnected',
        redis: redisStatus ? 'connected' : 'disconnected'
      }
    });
  } catch (error) {
    res.status(503).json({
      status: 'unhealthy',
      error: error.message
    });
  }
});

export default router;