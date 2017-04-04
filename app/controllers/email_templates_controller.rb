class EmailTemplatesController < ApplicationController

  before_filter :get_group, :set_language

  # GET /email_templates
  # GET /email_templates.json
  def index
    @email_templates = if @group
      @group.email_templates.order("version desc")
    else
      EmailTemplate.where("1=1")
    end
    @email_templates = @email_templates.where(language: params[:language]) if params[:language]
    # @email_templates = @email_templates.group_by(&:type) if (params[:group_by] == 'type')

    unless request.xhr?
      @email_templates = @email_templates.paginate(:page => params[:page]).order('id DESC')
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @email_templates }
    end
  end

  # GET /email_templates/1
  # GET /email_templates/1.json
  def show
    @email_template = EmailTemplate.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @email_template }
    end
  end

  # GET /email_templates/new
  # GET /email_templates/new.json
  def new

    @groups = Group.all
    fields = @language ? {language: params[:language]} : {}
    @email_template = EmailTemplate.new(fields)
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @email_template }
    end
  end

  # GET /email_templates/1/edit
  def edit
    @email_template = EmailTemplate.find(params[:id])
  end

  # POST /email_templates
  # POST /email_templates.json
  def create
    @email_template = EmailTemplate.new(params[:email_template])
    respond_to do |format|

      if (@email_template.save)
        flash_message('Email template', true)
        format.html { redirect_to language_email_templates_path(@email_template.language)}
        format.json { render json: @email_template, status: :created, location: @email_template }
      else
        flash_message('Email template', false)
        format.html { render action: "new"}
        format.json { render json: @email_template.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /email_templates/1
  # PUT /email_templates/1.json
  def update
    @email_template = EmailTemplate.find(params[:id])

    respond_to do |format|
      if @email_template.update_attributes(params[:email_template])
        flash_message('Email template', true)
        format.html { redirect_to show_language_email_templates_path({id: @email_template.id, language: @email_template.language})}
        format.json { head :no_content }
      else
        flash_message('Email template', false)
        format.html { render action: "edit"}
        format.json { render json: @email_template.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /email_templates/1
  # DELETE /email_templates/1.json
  def destroy
    @email_template = EmailTemplate.find(params[:id])
    @email_template.destroy
    flash_message('Email template', true)
    respond_to do |format|
      format.html { redirect_to "/email_templates/#{@email_template.language}" }
      format.json { head :no_content }
    end
  end

  private
  def get_group
    @group = Group.find_by_id(params[:group_id]) if params[:group_id]
  end

  #TODO: trace the usage
  def set_language
    @language = params[:email_template].present? ? params[:email_template][:language] : params[:language]
    @language ||= "english"
  end
end
