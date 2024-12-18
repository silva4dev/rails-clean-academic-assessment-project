import { GetTopStudentsService } from "../../domain/services/get-top-students-service"
import { makeApiUrl, makeAxiosHttpClient } from "../../shared_kernel"
import { HttpGetTopStudentsService } from "../services/http-get-top-students-service"

export const makeHttpGetTopStudentsService = (): GetTopStudentsService =>
  new HttpGetTopStudentsService(makeApiUrl("/api/v1/students"), makeAxiosHttpClient())
