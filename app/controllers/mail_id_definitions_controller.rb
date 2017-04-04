class MailIdDefinitionsController < ApplicationController
  # GET /mail_id_definitions
  # GET /mail_id_definitions.json
  def index
    @mail_id_definitions = MailIdDefinition.paginate(:page => params[:page]).order('id DESC')

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @mail_id_definitions }
    end
  end

  # GET /mail_id_definitions/1
  # GET /mail_id_definitions/1.json
  def show
    @mail_id_definition = MailIdDefinition.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @mail_id_definition }
    end
  end

  # GET /mail_id_definitions/new
  # GET /mail_id_definitions/new.json
  def new
    @mail_id_definition = MailIdDefinition.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @mail_id_definition }
    end
  end

  # GET /mail_id_definitions/1/edit
  def edit
    @mail_id_definition = MailIdDefinition.find(params[:id])
  end

  # POST /mail_id_definitions
  # POST /mail_id_definitions.json
  def create
    @mail_id_definition = MailIdDefinition.new(params[:mail_id_definition])

    respond_to do |format|
      if @mail_id_definition.save
        flash_message('Mail ID Definition', true)
        format.html { redirect_to @mail_id_definition}
        format.json { render json: @mail_id_definition, status: :created, location: @mail_id_definition }
      else
        flash_message('Mail ID Definition', false)
        format.html { render action: "new" }
        format.json { render json: @mail_id_definition.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /mail_id_definitions/1
  # PUT /mail_id_definitions/1.json
  def update
    @mail_id_definition = MailIdDefinition.find(params[:id])

    respond_to do |format|
      if @mail_id_definition.update_attributes(params[:mail_id_definition])
        flash_message('Mail ID Definition', true)
        format.html { redirect_to @mail_id_definition}
        format.json { head :no_content }
      else
        flash_message('Mail ID Definition', false)
        format.html { render action: "edit" }
        format.json { render json: @mail_id_definition.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /mail_id_definitions/1
  # DELETE /mail_id_definitions/1.json
  def destroy
    @mail_id_definition = MailIdDefinition.find(params[:id])
    @mail_id_definition.destroy
    flash_message('Mail ID Definition', true)

    respond_to do |format|
      format.html { redirect_to mail_id_definitions_url }
      format.json { head :no_content }
    end
  end
end
