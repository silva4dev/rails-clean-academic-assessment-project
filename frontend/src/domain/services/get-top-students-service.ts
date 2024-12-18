import { Either, Service } from "../../shared_kernel";
import { HistoryEntity } from "../entities";

export type GetTopStudentsResponse = Either<null, {
  data: HistoryEntity[]
}>;

export interface GetTopStudentsService
  extends Service<null, GetTopStudentsResponse> {}