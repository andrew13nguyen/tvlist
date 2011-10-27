class List < ActiveRecord::Base
#   validates_presence_of :title, :episode
#   attr_accessible :title, :episode, :ongoing
#   
#   def self.get_ongoing(sort = "title")
#     sql_str = <<SQLSTR
# SELECT `lists`.* FROM `lists` WHERE `lists`.ongoing = TRUE ORDER BY #{sort}
# SQLSTR
#     self.find_by_sql(sql_str)
#   end
#   
#   def self.get_complete(sort = "title", order = nil)
#     sql_str = <<SQLSTR
# SELECT `lists`.* FROM `lists` WHERE `lists`.ongoing = FALSE ORDER BY #{sort}
# SQLSTR
#     self.find_by_sql(sql_str)
#   end
end
