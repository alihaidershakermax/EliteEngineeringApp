import { Injectable } from '@nestjs/common';

@Injectable()
export class AppService {
  getHello(): object {
    return {
      message: 'Welcome to Elite Engineering Gathering API',
      version: '1.0.0',
      endpoints: {
        auth: '/api/auth',
        users: '/api/users',
        activities: '/api/activities',
        tasks: '/api/tasks',
        announcements: '/api/announcements',
        events: '/api/events',
      },
    };
  }
}
