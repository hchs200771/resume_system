class Api::V1::ResumesController < ApplicationController
  def search
    render json: { data: ResumeSearchService.new.perform(params) }
  end
end
