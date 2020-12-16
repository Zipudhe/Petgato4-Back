class ReportsController < ApplicationController
    before_action :set_report, only: [:show, :update, :destroy]

    def index
        @reports = Report.all
        render json:@reports, status: 200
    end

    def show
        render json:@report, status: 200
    end
    
    def create
        @report = Report.new(report_params)
        if @report.save
            render json: @report, status: 201
        else
            render json: @report.errors, status: :unprocessable_entity
        end
    end

    def update
        if @report.update(report_params)
            render json: @report, status: 200
        else
            render json: @report.errors, status: :unprocessable_entity
        end
    end

    def destroy
        @report.destroy
    end

    private

    def set_report
        @report = Report.find(params[:id])
    end

    def report_params
        params.require(:report).permit(:reply_id, :comment_id)
    end

end