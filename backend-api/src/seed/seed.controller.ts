import { Controller, Post } from '@nestjs/common';
import { SeedService } from './seed.service';

@Controller('seed')
export class SeedController {
  constructor(private seedService: SeedService) {}

  @Post()
  async seed() {
    await this.seedService.seedAll();
    return {
      message: 'تم إضافة البيانات التجريبية بنجاح',
      success: true,
    };
  }
}
