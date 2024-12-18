import { makeApiUrl, makeAxiosHttpClient } from "../../../shared_kernel";
import { makeHttpGetStudentMaxGradeService } from "../../factories/http-get-student-max-grade-service-factory";

jest.mock("axios");

jest.mock("../../../shared_kernel", () => ({
  makeApiUrl: jest.fn(),
  makeAxiosHttpClient: jest.fn(),
}));

describe("makeHttpGetStudentMaxGradeService", () => {
  const mockApiUrl = "http://example.com/api/v1/student";
  const mockHttpClient = { request: jest.fn() };

  beforeEach(() => {
    (makeApiUrl as jest.Mock).mockReturnValue(mockApiUrl);
    (makeAxiosHttpClient as jest.Mock).mockReturnValue(mockHttpClient);
  });

  it("should call makeApiUrl with the correct argument", () => {
    makeHttpGetStudentMaxGradeService();
    expect(makeApiUrl).toHaveBeenCalledWith("/api/v1/student");
  });

  it("should call makeAxiosHttpClient", () => {
    makeHttpGetStudentMaxGradeService();
    expect(makeAxiosHttpClient).toHaveBeenCalled();
  });

  it("should pass the correct arguments to HttpGetStudentMaxGradeService constructor", () => {
    const service = makeHttpGetStudentMaxGradeService();

    expect((service as any).url).toBe(mockApiUrl);
    expect((service as any).httpGetClient).toBe(mockHttpClient);
  });
});
