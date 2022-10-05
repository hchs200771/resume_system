class ResumeSearchService
  def perform(params)
    same_company = params[:same_company] == "true"
    years = params[:work_exprience].to_i
    candidate_ids = match_candidate_ids(same_company, years)
    Candidate.includes(:resumes).where(id: candidate_ids).map do |candidate|
      has_match_exp = candidate.work_experiences.find { |exp| exp.years == years }
      company_name = has_match_exp ? has_match_exp.company : candidate.work_experiences.map(&:company).join(", ")
      {
        id: candidate.id,
        name: candidate.name,
        company: company_name,
        years: years,
        resumes: candidate.resumes.map do |resume|
          {
            id: resume.id,
            name: resume.name,
            template: resume.template,
          }
        end
      }
    end
  end

  private

  def match_candidate_ids(same_company, years)
    if same_company
      WorkExperience.where(years: years).pluck(:candidate_id)
    else
      WorkExperience.group(:candidate_id).sum(:years)
                    .select { | _candidate_id, total_years| total_years == years }
                    .keys
    end
  end
end
