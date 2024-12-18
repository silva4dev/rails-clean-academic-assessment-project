import { Either, Service } from "../../shared_kernel";
import { HistoryEntity } from "../entities";

export type GetHistoriesResponse = Either<null, {
  data: HistoryEntity[]
}>;

export interface GetHistoriesService
  extends Service<null, GetHistoriesResponse> {}