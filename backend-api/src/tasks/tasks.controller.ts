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
import { TasksService } from './tasks.service';
import { JwtAuthGuard } from '../auth/guards/jwt-auth.guard';
import { CreateTaskDto, UpdateTaskDto } from './dto/task.dto';

@Controller('tasks')
@UseGuards(JwtAuthGuard)
export class TasksController {
  constructor(private tasksService: TasksService) {}

  @Get()
  async findAll(@Request() req, @Query('status') status?: string) {
    if (status) {
      return this.tasksService.findByStatus(req.user.userId, status);
    }
    return this.tasksService.findAll(req.user.userId);
  }

  @Get('statistics')
  async getStatistics(@Request() req) {
    return this.tasksService.getStatistics(req.user.userId);
  }

  @Get(':id')
  async findById(@Param('id') id: string, @Request() req) {
    return this.tasksService.findById(id, req.user.userId);
  }

  @Post()
  async create(@Body() createTaskDto: CreateTaskDto, @Request() req) {
    return this.tasksService.create(req.user.userId, createTaskDto);
  }

  @Put(':id')
  async update(
    @Param('id') id: string,
    @Body() updateTaskDto: UpdateTaskDto,
    @Request() req,
  ) {
    return this.tasksService.update(id, req.user.userId, updateTaskDto);
  }

  @Delete(':id')
  async delete(@Param('id') id: string, @Request() req) {
    return this.tasksService.delete(id, req.user.userId);
  }
}
