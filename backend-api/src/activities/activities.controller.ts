import {
  Controller,
  Get,
  Post,
  Put,
  Delete,
  Body,
  Param,
  UseGuards,
  Request,
  Query,
} from '@nestjs/common';
import { ActivitiesService } from './activities.service';
import { JwtAuthGuard } from '../auth/guards/jwt-auth.guard';
import { CreateActivityDto, RegisterActivityDto } from './dto/activity.dto';

@Controller('activities')
export class ActivitiesController {
  constructor(private activitiesService: ActivitiesService) {}

  @Get()
  async findAll(@Query('category') category?: string) {
    if (category) {
      return this.activitiesService.findByCategory(category);
    }
    return this.activitiesService.findAll();
  }

  @Get('my-activities')
  @UseGuards(JwtAuthGuard)
  async getMyActivities(@Request() req) {
    return this.activitiesService.getUserActivities(req.user.userId);
  }

  @Get(':id')
  async findById(@Param('id') id: string) {
    return this.activitiesService.findById(id);
  }

  @Post()
  @UseGuards(JwtAuthGuard)
  async create(@Body() createActivityDto: CreateActivityDto) {
    return this.activitiesService.create(createActivityDto);
  }

  @Post(':id/register')
  @UseGuards(JwtAuthGuard)
  async register(
    @Param('id') id: string,
    @Request() req,
    @Body() registerDto: RegisterActivityDto,
  ) {
    return this.activitiesService.register(id, req.user.userId, registerDto);
  }

  @Put(':id')
  @UseGuards(JwtAuthGuard)
  async update(@Param('id') id: string, @Body() updateData: any) {
    return this.activitiesService.update(id, updateData);
  }

  @Delete(':id')
  @UseGuards(JwtAuthGuard)
  async delete(@Param('id') id: string) {
    return this.activitiesService.delete(id);
  }
}
