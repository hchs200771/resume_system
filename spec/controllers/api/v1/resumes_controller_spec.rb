require "rails_helper"

RSpec.describe Api::V1::ResumesController, type: :request do
  before do
    # Davis"s records
    candidate_davis = Candidate.create(name: "Davis")
    candidate_davis.resumes.create(
      [{ name: "A", template: "A1" }, { name: "A", template: "A2" }, { name: "B", template: "B1" }]
    )
    candidate_davis.work_experiences.create([{ company: "Morrison Express", years: 5 }])

    # Max"s records
    candidate_max = Candidate.create(name: "Max")
    candidate_max.resumes.create([{ name: "C", template: "C1" }, { name: "S", template: "S1" }])
    candidate_max.work_experiences.create([
      { company: "Cyberbiz", years: 1 }, { company: "Solmate", years: 1 }, { company: "Morrison Express", years: 3 }
    ])
  end

  describe "#search" do
    before { host! "127.0.0.1:3000" }

    subject do
      get api_v1_resumes_search_path, params: requrest_params
      { data: JSON.parse(response.body)["data"].map(&:deep_symbolize_keys) }
    end

    context "resumes in the same company for 6 years" do
      let(:requrest_params) { { work_exprience: 6, same_company: true } }
      it "will return empty array" do
        is_expected.to eq({ data: [] })
      end
    end

    context "resumes in the same company for 5 years" do
      let(:requrest_params) { { work_exprience: 5, same_company: true } }
      it "will return Davis" do
        is_expected.to eq({
          data:
            [{
              id: 1,
              name: "Davis",
              company: "Morrison Express",
              years: 5,
              resumes: [
                {
                  id: 1,
                  name: "A",
                  template: "A1"
                },
                {
                  id: 2,
                  name: "A",
                  template: "A2"
                },
                {
                  id: 3,
                  name: "B",
                  template: "B1"
                }
              ]
            }]
          })
      end
    end

    context "resumes not in the same companies for 5 years" do
      let(:requrest_params) { { work_exprience: 5, same_company: false } }
      it "will return Davis, Max" do
        is_expected.to eq({
          data:
            [{
              id: 1,
              name: "Davis",
              company: "Morrison Express",
              years: 5,
              resumes: [
                {
                  id: 1,
                  name: "A",
                  template: "A1"
                },
                {
                  id: 2,
                  name: "A",
                  template: "A2"
                },
                {
                  id: 3,
                  name: "B",
                  template: "B1"
                }
              ]
            },
            {
              id: 2,
              name: "Max",
              company: "Cyberbiz, Solmate, Morrison Express",
              years: 5,
              resumes: [
                {
                  id: 4,
                  name: "C",
                  template: "C1"
                },
                {
                  id: 5,
                  name: "S",
                  template: "S1"
                }
              ]
            }]
          })
      end
    end
  end
end
