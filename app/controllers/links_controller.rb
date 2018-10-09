class LinksController < ApplicationController
  #POST /link/parse
  def parse_url
    url = sanitise_url(params[:url])
    existing = Link.find_by(url: url)
    puts existing.inspect
    return render :json => { :data => existing.target } unless existing.blank?

    @link = Link.new({url: url})
    if @link.save
      return render :json => { :data => @link.target } 
    else
      return render :json => { :errors => @link.errors }, :status => 400
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_link
      @link = Link.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def link_params
      params.require(:link).permit(:url, :type, :track_id, :playlist_id, :album_id, :artist_id)
    end
end
