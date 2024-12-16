import { HistoryEntity } from "../../domain/entities";
import { GetHistoriesResponse, GetHistoriesService } from "../../domain/services";
import { HttpClient, Right } from "../../shared_kernel";

export class HttpGetHistoriesService implements GetHistoriesService {
  private readonly url: string;
  private readonly httpGetClient: HttpClient<GetHistoriesResponse>;

  constructor(
    url: string,
    httpGetClient: HttpClient<GetHistoriesResponse>
  ) {
    this.url = url;
    this.httpGetClient = httpGetClient
  }

  async execute(): Promise<GetHistoriesResponse> {
    const httpResponse = await this.httpGetClient.request({
      url: this.url,
      method: "get",
      body: {}
    })

    return Right<HistoryEntity>(httpResponse?.body?.value!)
  }
}