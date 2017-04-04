class OpportunityGeneratorsController < ApplicationController
  # GET /opportunity_generators
  # GET /opportunity_generators.json
  def index
    @opportunity_generators = OpportunityGenerator.paginate(:page => params[:page]).order('id DESC')

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @opportunity_generators }
    end
  end

  # GET /opportunity_generators
  # GET /opportunity_generators.json
  def review
    filters = []
    OpportunityGenerator.filter_conditions.keys.each do |field|
      if params[field].present?
        filters << OpportunityGenerator.filter_conditions[field].gsub("?", params[field])
      end
    end
    condition = filters.present? ? filters.join(" AND ") : "1=1"
    @opportunity_generators = OpportunityGenerator.review_search(condition)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @opportunity_generators }
    end
  end

  def update_status
    message = 'Updated successfully!'
    if params[:status].present? && params[:ids].present?
      if params[:status] == OpportunityGenerator.statuses[:mail]
        params[:ids].each do | oportunity_id, template_id|
          opportunity_generators = OpportunityGenerator.where(id: oportunity_id, status: OpportunityGenerator::STATUSES[0])
          email_template = EmailTemplate.where(id: template_id).first

          opportunity_generators.each do |opportunity_generator|
            NotifierMailer.opportunity(email_template, opportunity_generator).deliver
            opportunity_generator.update_attributes({status: params[:status]})
          end if email_template.present?
        end
        message = 'Mail sent successfully!'
      else
        params[:ids].each do | oportunity_id, template_id|
          opportunity_generator = OpportunityGenerator.where(id: oportunity_id)
          opportunity_generator.update_all({status: params[:status]})
        end
      end
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: {message: message, opportunity_generators: OpportunityGenerator.review_search("1=1")}}
    end
  end

  # GET /opportunity_generators/1
  # GET /opportunity_generators/1.json
  def show
    @opportunity_generator = OpportunityGenerator.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @opportunity_generator }
    end
  end

  # GET /opportunity_generators/new
  # GET /opportunity_generators/new.json
  def new
    @opportunity_generator = OpportunityGenerator.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @opportunity_generator }
    end
  end

  # GET /opportunity_generators/new_import
  def new_import
    respond_to do |format|
      format.html # new_import.html.erb
    end
  end

  # GET /opportunity_generators/1/edit
  def edit
    @opportunity_generator = OpportunityGenerator.find(params[:id])
  end

  # POST /opportunity_generators
  # POST /opportunity_generators.json
  def create
    @opportunity_generator = OpportunityGenerator.new(params[:opportunity_generator])

    respond_to do |format|
      if @opportunity_generator.save
        flash_message('Opportunity generator', true)
        format.html { redirect_to @opportunity_generator}
        format.json { render json: @opportunity_generator, status: :created, location: @opportunity_generator }
      else
        flash_message('Opportunity generator', false)
        format.html { render action: "new" }
        format.json { render json: @opportunity_generator.errors, status: :unprocessable_entity }
      end
    end
  end

  def import
    OpportunityGenerator.import(params[:file])
    redirect_to opportunity_generators_url
  end

  # PUT /opportunity_generators/1
  # PUT /opportunity_generators/1.json
  def update
    @opportunity_generator = OpportunityGenerator.find(params[:id])

    respond_to do |format|
      if @opportunity_generator.update_attributes(params[:opportunity_generator])
        flash_message('Opportunity generator', true)
        format.html { redirect_to @opportunity_generator}
        format.json { head :no_content }
      else
        flash_message('Opportunity generator', false)
        format.html { render action: "edit" }
        format.json { render json: @opportunity_generator.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /opportunity_generators/1
  # DELETE /opportunity_generators/1.json
  def destroy
    @opportunity_generator = OpportunityGenerator.find(params[:id])
    @opportunity_generator.destroy
    flash_message('Opportunity generator', true)

    respond_to do |format|
      format.html { redirect_to opportunity_generators_url }
      format.json { head :no_content }
    end
  end
end
