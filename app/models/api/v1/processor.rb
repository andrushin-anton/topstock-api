class Api::V1::Processor < ApplicationRecord

  STATUS_ACTIVE = 'ACTIVE'
  STATUS_RUNNING = 'RUNNING'
  STATUS_ERROR = 'ERROR'

  TYPE_STATS = 'STATS'
  TYPE_RANK = 'RANK'
  TYPE_IMPORT = 'IMPORT'

end
