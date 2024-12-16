import { Either, Service } from "../../shared_kernel";
import { HistoryEntity } from "../entities";

export type Request = {
  name: string;
  capacity: number;
  location: string;
};

export type GetHistoriesResponse = Either<null, HistoryEntity>;

export interface GetHistoriesService
  extends Service<null, GetHistoriesResponse> {}