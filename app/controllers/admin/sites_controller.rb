class Admin::SitesController < AdminController
  def index
    @sites = Site.all
  end

  def new
    #code
  end

  def edit
    @site = Site.find(params[:id])
  end

  def create
    @site = Site.new(site_params)
    if @site.save
      flash[:success] = 'サイトを新たに追加しました！'
      redirect_to admin_sites_path
    else
      flash[:danger] = 'サイトを追加できませんでした。'
      redirect_to new_admin_sites_path
    end
  end

  def update
    @site = Site.find(params[:id])
    if @site.update(site_params)
      flash[:success] = 'サイト情報を更新しました。'
      redirect_to admin_sites_path
    else
      flash[:success] = 'サイト情報を更新できませんでした。'
      redirect_to edit_admin_sites_path(@site)
    end
  end

  private
  def site_params
    params.require(:site).permit!
  end

end
