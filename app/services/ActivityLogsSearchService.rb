class ActivityLogsSearchService
  def self.find_hash(params)
    hash = {:params => {}, :query => ""}
    if !params[:baby_id].nil? && params[:baby_id].present?
      hash[:params][:baby_id] = params[:baby_id]
      hash[:query] =  "#{hash[:query]}_baby_id_#{params[:baby_id]}_"
    end
    if !params[:assistant_id].nil? && params[:assistant_id].present?
      hash[:params][:assistant_id] = params[:assistant_id]
      hash[:query] =  "#{hash[:query]}_assistant_id_#{params[:assistant_id]}_"
    end
    if !params[:activity_id].nil? && params[:activity_id].present?
      hash[:params][:activity_id] = params[:activity_id]
      hash[:query] =  "#{hash[:query]}_activity_id_#{params[:activity_id]}_"
    end
    if !params[:status].nil? && params[:status].present?
      hash[:params][:status] = params[:status]
      hash[:query] =  "#{hash[:query]}_status_#{params[:status]}_"
    end
    return hash
  end
  def self.search(curr_logs,hash)
    activity_logs_ids = Rails.cache.fetch("activity_logs_search/#{hash[:query]}", expires_in: 20.minutes) do
      curr_logs.where(hash[:params]).map(&:id)
    end
    curr_logs.where(id: activity_logs_ids)
  end
end