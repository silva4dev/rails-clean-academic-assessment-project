import { GetHistoriesService } from "../../domain/services"
import { makeApiUrl, makeAxiosHttpClient } from "../../shared_kernel"
import { HttpGetHistoriesService } from "../services"

export const makeHttpGetHistoriesService = (id: string): GetHistoriesService =>
  new HttpGetHistoriesService(makeApiUrl(`/api/v1/histories/students/${id}`), makeAxiosHttpClient())
