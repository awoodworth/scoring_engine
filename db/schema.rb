# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160419174222) do

  create_table "events", force: :cascade do |t|
    t.string   "name",           limit: 255
    t.datetime "available_at"
    t.datetime "unavailable_at"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "flag_categories", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.integer  "event_id",    limit: 4
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.text     "description", limit: 65535
  end

  add_index "flag_categories", ["event_id"], name: "index_flag_categories_on_event_id", using: :btree

  create_table "flag_submissions", force: :cascade do |t|
    t.integer "user_id",         limit: 4
    t.integer "flag_id",         limit: 4
    t.text    "submission_text", limit: 65535
    t.boolean "correct",                       default: false
  end

  add_index "flag_submissions", ["flag_id"], name: "index_flag_submissions_on_flag_id", using: :btree
  add_index "flag_submissions", ["user_id"], name: "index_flag_submissions_on_user_id", using: :btree

  create_table "flags", force: :cascade do |t|
    t.integer "flag_category_id", limit: 4
    t.string  "question",         limit: 255
    t.text    "comment",          limit: 65535
    t.integer "points",           limit: 4
    t.integer "max_attempts",     limit: 4
    t.text    "answer",           limit: 65535
    t.text    "possible_answers", limit: 65535
    t.string  "kind",             limit: 255
    t.integer "parent_id",        limit: 4
    t.integer "position",         limit: 4
    t.string  "difficulty_level", limit: 255
  end

  add_index "flags", ["flag_category_id"], name: "index_flags_on_flag_category_id", using: :btree
  add_index "flags", ["parent_id"], name: "index_flags_on_parent_id", using: :btree
  add_index "flags", ["position"], name: "index_flags_on_position", using: :btree

  create_table "groups", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "groups", ["name"], name: "index_groups_on_name", unique: true, using: :btree

  create_table "guides", force: :cascade do |t|
    t.string   "file_file_name",    limit: 255
    t.string   "file_content_type", limit: 255
    t.integer  "file_file_size",    limit: 4
    t.datetime "file_updated_at"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  create_table "inject_responses", force: :cascade do |t|
    t.datetime "created_at",                                                  null: false
    t.datetime "updated_at",                                                  null: false
    t.string   "submission_file_name",    limit: 255
    t.string   "submission_content_type", limit: 255
    t.integer  "submission_file_size",    limit: 4
    t.datetime "submission_updated_at"
    t.integer  "user_id",                 limit: 4
    t.integer  "inject_id",               limit: 4
    t.decimal  "score",                               precision: 4, scale: 1
  end

  add_index "inject_responses", ["inject_id"], name: "index_inject_responses_on_inject_id", using: :btree
  add_index "inject_responses", ["user_id"], name: "index_inject_responses_on_user_id", using: :btree

  create_table "injects", force: :cascade do |t|
    t.string   "title",        limit: 255
    t.text     "description",  limit: 65535
    t.datetime "available_at"
    t.datetime "due_at"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.integer  "max_score",    limit: 4,     default: 0
    t.integer  "event_id",     limit: 4
  end

  add_index "injects", ["event_id"], name: "index_injects_on_event_id", using: :btree

  create_table "nagios_acknowledgements", primary_key: "acknowledgement_id", force: :cascade do |t|
    t.integer  "instance_id",          limit: 2,   default: 0,  null: false
    t.datetime "entry_time",                                    null: false
    t.integer  "entry_time_usec",      limit: 4,   default: 0,  null: false
    t.integer  "acknowledgement_type", limit: 2,   default: 0,  null: false
    t.integer  "object_id",            limit: 4,   default: 0,  null: false
    t.integer  "state",                limit: 2,   default: 0,  null: false
    t.string   "author_name",          limit: 64,  default: "", null: false
    t.string   "comment_data",         limit: 255, default: "", null: false
    t.integer  "is_sticky",            limit: 2,   default: 0,  null: false
    t.integer  "persistent_comment",   limit: 2,   default: 0,  null: false
    t.integer  "notify_contacts",      limit: 2,   default: 0,  null: false
  end

  create_table "nagios_commands", primary_key: "command_id", force: :cascade do |t|
    t.integer "instance_id",  limit: 2,   default: 0,  null: false
    t.integer "config_type",  limit: 2,   default: 0,  null: false
    t.integer "object_id",    limit: 4,   default: 0,  null: false
    t.string  "command_line", limit: 255, default: "", null: false
  end

  add_index "nagios_commands", ["instance_id", "object_id", "config_type"], name: "instance_id", unique: true, using: :btree

  create_table "nagios_commenthistory", primary_key: "commenthistory_id", force: :cascade do |t|
    t.integer  "instance_id",         limit: 2,   default: 0,  null: false
    t.datetime "entry_time",                                   null: false
    t.integer  "entry_time_usec",     limit: 4,   default: 0,  null: false
    t.integer  "comment_type",        limit: 2,   default: 0,  null: false
    t.integer  "entry_type",          limit: 2,   default: 0,  null: false
    t.integer  "object_id",           limit: 4,   default: 0,  null: false
    t.datetime "comment_time",                                 null: false
    t.integer  "internal_comment_id", limit: 4,   default: 0,  null: false
    t.string   "author_name",         limit: 64,  default: "", null: false
    t.string   "comment_data",        limit: 255, default: "", null: false
    t.integer  "is_persistent",       limit: 2,   default: 0,  null: false
    t.integer  "comment_source",      limit: 2,   default: 0,  null: false
    t.integer  "expires",             limit: 2,   default: 0,  null: false
    t.datetime "expiration_time",                              null: false
    t.datetime "deletion_time",                                null: false
    t.integer  "deletion_time_usec",  limit: 4,   default: 0,  null: false
  end

  add_index "nagios_commenthistory", ["instance_id", "comment_time", "internal_comment_id"], name: "instance_id", unique: true, using: :btree

  create_table "nagios_comments", primary_key: "comment_id", force: :cascade do |t|
    t.integer  "instance_id",         limit: 2,   default: 0,  null: false
    t.datetime "entry_time",                                   null: false
    t.integer  "entry_time_usec",     limit: 4,   default: 0,  null: false
    t.integer  "comment_type",        limit: 2,   default: 0,  null: false
    t.integer  "entry_type",          limit: 2,   default: 0,  null: false
    t.integer  "object_id",           limit: 4,   default: 0,  null: false
    t.datetime "comment_time",                                 null: false
    t.integer  "internal_comment_id", limit: 4,   default: 0,  null: false
    t.string   "author_name",         limit: 64,  default: "", null: false
    t.string   "comment_data",        limit: 255, default: "", null: false
    t.integer  "is_persistent",       limit: 2,   default: 0,  null: false
    t.integer  "comment_source",      limit: 2,   default: 0,  null: false
    t.integer  "expires",             limit: 2,   default: 0,  null: false
    t.datetime "expiration_time",                              null: false
  end

  add_index "nagios_comments", ["instance_id", "comment_time", "internal_comment_id"], name: "instance_id", unique: true, using: :btree

  create_table "nagios_configfiles", primary_key: "configfile_id", force: :cascade do |t|
    t.integer "instance_id",     limit: 2,   default: 0,  null: false
    t.integer "configfile_type", limit: 2,   default: 0,  null: false
    t.string  "configfile_path", limit: 255, default: "", null: false
  end

  add_index "nagios_configfiles", ["instance_id", "configfile_type", "configfile_path"], name: "instance_id", unique: true, using: :btree

  create_table "nagios_configfilevariables", primary_key: "configfilevariable_id", force: :cascade do |t|
    t.integer "instance_id",   limit: 2,   default: 0,  null: false
    t.integer "configfile_id", limit: 4,   default: 0,  null: false
    t.string  "varname",       limit: 64,  default: "", null: false
    t.string  "varvalue",      limit: 255, default: "", null: false
  end

  create_table "nagios_conninfo", primary_key: "conninfo_id", force: :cascade do |t|
    t.integer  "instance_id",       limit: 2,  default: 0,  null: false
    t.string   "agent_name",        limit: 32, default: "", null: false
    t.string   "agent_version",     limit: 8,  default: "", null: false
    t.string   "disposition",       limit: 16, default: "", null: false
    t.string   "connect_source",    limit: 16, default: "", null: false
    t.string   "connect_type",      limit: 16, default: "", null: false
    t.datetime "connect_time",                              null: false
    t.datetime "disconnect_time",                           null: false
    t.datetime "last_checkin_time",                         null: false
    t.datetime "data_start_time",                           null: false
    t.datetime "data_end_time",                             null: false
    t.integer  "bytes_processed",   limit: 4,  default: 0,  null: false
    t.integer  "lines_processed",   limit: 4,  default: 0,  null: false
    t.integer  "entries_processed", limit: 4,  default: 0,  null: false
  end

  create_table "nagios_contact_addresses", primary_key: "contact_address_id", force: :cascade do |t|
    t.integer "instance_id",    limit: 2,   default: 0,  null: false
    t.integer "contact_id",     limit: 4,   default: 0,  null: false
    t.integer "address_number", limit: 2,   default: 0,  null: false
    t.string  "address",        limit: 255, default: "", null: false
  end

  add_index "nagios_contact_addresses", ["contact_id", "address_number"], name: "contact_id", unique: true, using: :btree

  create_table "nagios_contact_notificationcommands", primary_key: "contact_notificationcommand_id", force: :cascade do |t|
    t.integer "instance_id",       limit: 2,   default: 0,  null: false
    t.integer "contact_id",        limit: 4,   default: 0,  null: false
    t.integer "notification_type", limit: 2,   default: 0,  null: false
    t.integer "command_object_id", limit: 4,   default: 0,  null: false
    t.string  "command_args",      limit: 255, default: "", null: false
  end

  add_index "nagios_contact_notificationcommands", ["contact_id", "notification_type", "command_object_id", "command_args"], name: "contact_id", unique: true, using: :btree

  create_table "nagios_contactgroup_members", primary_key: "contactgroup_member_id", force: :cascade do |t|
    t.integer "instance_id",       limit: 2, default: 0, null: false
    t.integer "contactgroup_id",   limit: 4, default: 0, null: false
    t.integer "contact_object_id", limit: 4, default: 0, null: false
  end

  add_index "nagios_contactgroup_members", ["contactgroup_id", "contact_object_id"], name: "instance_id", unique: true, using: :btree

  create_table "nagios_contactgroups", primary_key: "contactgroup_id", force: :cascade do |t|
    t.integer "instance_id",            limit: 2,   default: 0,  null: false
    t.integer "config_type",            limit: 2,   default: 0,  null: false
    t.integer "contactgroup_object_id", limit: 4,   default: 0,  null: false
    t.string  "alias",                  limit: 255, default: "", null: false
  end

  add_index "nagios_contactgroups", ["instance_id", "config_type", "contactgroup_object_id"], name: "instance_id", unique: true, using: :btree

  create_table "nagios_contactnotificationmethods", primary_key: "contactnotificationmethod_id", force: :cascade do |t|
    t.integer  "instance_id",            limit: 2,   default: 0,  null: false
    t.integer  "contactnotification_id", limit: 4,   default: 0,  null: false
    t.datetime "start_time",                                      null: false
    t.integer  "start_time_usec",        limit: 4,   default: 0,  null: false
    t.datetime "end_time",                                        null: false
    t.integer  "end_time_usec",          limit: 4,   default: 0,  null: false
    t.integer  "command_object_id",      limit: 4,   default: 0,  null: false
    t.string   "command_args",           limit: 255, default: "", null: false
  end

  add_index "nagios_contactnotificationmethods", ["instance_id", "contactnotification_id", "start_time", "start_time_usec"], name: "instance_id", unique: true, using: :btree

  create_table "nagios_contactnotifications", primary_key: "contactnotification_id", force: :cascade do |t|
    t.integer  "instance_id",       limit: 2, default: 0, null: false
    t.integer  "notification_id",   limit: 4, default: 0, null: false
    t.integer  "contact_object_id", limit: 4, default: 0, null: false
    t.datetime "start_time",                              null: false
    t.integer  "start_time_usec",   limit: 4, default: 0, null: false
    t.datetime "end_time",                                null: false
    t.integer  "end_time_usec",     limit: 4, default: 0, null: false
  end

  add_index "nagios_contactnotifications", ["instance_id", "contact_object_id", "start_time", "start_time_usec"], name: "instance_id", unique: true, using: :btree

  create_table "nagios_contacts", primary_key: "contact_id", force: :cascade do |t|
    t.integer "instance_id",                   limit: 2,   default: 0,  null: false
    t.integer "config_type",                   limit: 2,   default: 0,  null: false
    t.integer "contact_object_id",             limit: 4,   default: 0,  null: false
    t.string  "alias",                         limit: 64,  default: "", null: false
    t.string  "email_address",                 limit: 255, default: "", null: false
    t.string  "pager_address",                 limit: 64,  default: "", null: false
    t.integer "host_timeperiod_object_id",     limit: 4,   default: 0,  null: false
    t.integer "service_timeperiod_object_id",  limit: 4,   default: 0,  null: false
    t.integer "host_notifications_enabled",    limit: 2,   default: 0,  null: false
    t.integer "service_notifications_enabled", limit: 2,   default: 0,  null: false
    t.integer "can_submit_commands",           limit: 2,   default: 0,  null: false
    t.integer "notify_service_recovery",       limit: 2,   default: 0,  null: false
    t.integer "notify_service_warning",        limit: 2,   default: 0,  null: false
    t.integer "notify_service_unknown",        limit: 2,   default: 0,  null: false
    t.integer "notify_service_critical",       limit: 2,   default: 0,  null: false
    t.integer "notify_service_flapping",       limit: 2,   default: 0,  null: false
    t.integer "notify_service_downtime",       limit: 2,   default: 0,  null: false
    t.integer "notify_host_recovery",          limit: 2,   default: 0,  null: false
    t.integer "notify_host_down",              limit: 2,   default: 0,  null: false
    t.integer "notify_host_unreachable",       limit: 2,   default: 0,  null: false
    t.integer "notify_host_flapping",          limit: 2,   default: 0,  null: false
    t.integer "notify_host_downtime",          limit: 2,   default: 0,  null: false
  end

  add_index "nagios_contacts", ["instance_id", "config_type", "contact_object_id"], name: "instance_id", unique: true, using: :btree

  create_table "nagios_contactstatus", primary_key: "contactstatus_id", force: :cascade do |t|
    t.integer  "instance_id",                   limit: 2, default: 0, null: false
    t.integer  "contact_object_id",             limit: 4, default: 0, null: false
    t.datetime "status_update_time",                                  null: false
    t.integer  "host_notifications_enabled",    limit: 2, default: 0, null: false
    t.integer  "service_notifications_enabled", limit: 2, default: 0, null: false
    t.datetime "last_host_notification",                              null: false
    t.datetime "last_service_notification",                           null: false
    t.integer  "modified_attributes",           limit: 4, default: 0, null: false
    t.integer  "modified_host_attributes",      limit: 4, default: 0, null: false
    t.integer  "modified_service_attributes",   limit: 4, default: 0, null: false
  end

  add_index "nagios_contactstatus", ["contact_object_id"], name: "contact_object_id", unique: true, using: :btree

  create_table "nagios_customvariables", primary_key: "customvariable_id", force: :cascade do |t|
    t.integer "instance_id",       limit: 2,   default: 0,  null: false
    t.integer "object_id",         limit: 4,   default: 0,  null: false
    t.integer "config_type",       limit: 2,   default: 0,  null: false
    t.integer "has_been_modified", limit: 2,   default: 0,  null: false
    t.string  "varname",           limit: 255, default: "", null: false
    t.string  "varvalue",          limit: 255, default: "", null: false
  end

  add_index "nagios_customvariables", ["object_id", "config_type", "varname"], name: "object_id_2", unique: true, using: :btree
  add_index "nagios_customvariables", ["varname"], name: "varname", using: :btree

  create_table "nagios_customvariablestatus", primary_key: "customvariablestatus_id", force: :cascade do |t|
    t.integer  "instance_id",        limit: 2,   default: 0,  null: false
    t.integer  "object_id",          limit: 4,   default: 0,  null: false
    t.datetime "status_update_time",                          null: false
    t.integer  "has_been_modified",  limit: 2,   default: 0,  null: false
    t.string   "varname",            limit: 255, default: "", null: false
    t.string   "varvalue",           limit: 255, default: "", null: false
  end

  add_index "nagios_customvariablestatus", ["object_id", "varname"], name: "object_id_2", unique: true, using: :btree
  add_index "nagios_customvariablestatus", ["varname"], name: "varname", using: :btree

  create_table "nagios_dbversion", id: false, force: :cascade do |t|
    t.string "name",    limit: 10, default: "", null: false
    t.string "version", limit: 10, default: "", null: false
  end

  create_table "nagios_downtimehistory", primary_key: "downtimehistory_id", force: :cascade do |t|
    t.integer  "instance_id",            limit: 2,   default: 0,  null: false
    t.integer  "downtime_type",          limit: 2,   default: 0,  null: false
    t.integer  "object_id",              limit: 4,   default: 0,  null: false
    t.datetime "entry_time",                                      null: false
    t.string   "author_name",            limit: 64,  default: "", null: false
    t.string   "comment_data",           limit: 255, default: "", null: false
    t.integer  "internal_downtime_id",   limit: 4,   default: 0,  null: false
    t.integer  "triggered_by_id",        limit: 4,   default: 0,  null: false
    t.integer  "is_fixed",               limit: 2,   default: 0,  null: false
    t.integer  "duration",               limit: 2,   default: 0,  null: false
    t.datetime "scheduled_start_time",                            null: false
    t.datetime "scheduled_end_time",                              null: false
    t.integer  "was_started",            limit: 2,   default: 0,  null: false
    t.datetime "actual_start_time",                               null: false
    t.integer  "actual_start_time_usec", limit: 4,   default: 0,  null: false
    t.datetime "actual_end_time",                                 null: false
    t.integer  "actual_end_time_usec",   limit: 4,   default: 0,  null: false
    t.integer  "was_cancelled",          limit: 2,   default: 0,  null: false
  end

  add_index "nagios_downtimehistory", ["instance_id", "object_id", "entry_time", "internal_downtime_id"], name: "instance_id", unique: true, using: :btree

  create_table "nagios_eventhandlers", primary_key: "eventhandler_id", force: :cascade do |t|
    t.integer  "instance_id",       limit: 2,     default: 0,   null: false
    t.integer  "eventhandler_type", limit: 2,     default: 0,   null: false
    t.integer  "object_id",         limit: 4,     default: 0,   null: false
    t.integer  "state",             limit: 2,     default: 0,   null: false
    t.integer  "state_type",        limit: 2,     default: 0,   null: false
    t.datetime "start_time",                                    null: false
    t.integer  "start_time_usec",   limit: 4,     default: 0,   null: false
    t.datetime "end_time",                                      null: false
    t.integer  "end_time_usec",     limit: 4,     default: 0,   null: false
    t.integer  "command_object_id", limit: 4,     default: 0,   null: false
    t.string   "command_args",      limit: 255,   default: "",  null: false
    t.string   "command_line",      limit: 255,   default: "",  null: false
    t.integer  "timeout",           limit: 2,     default: 0,   null: false
    t.integer  "early_timeout",     limit: 2,     default: 0,   null: false
    t.float    "execution_time",    limit: 53,    default: 0.0, null: false
    t.integer  "return_code",       limit: 2,     default: 0,   null: false
    t.string   "output",            limit: 255,   default: "",  null: false
    t.text     "long_output",       limit: 65535,               null: false
  end

  add_index "nagios_eventhandlers", ["instance_id", "object_id", "start_time", "start_time_usec"], name: "instance_id", unique: true, using: :btree

  create_table "nagios_externalcommands", primary_key: "externalcommand_id", force: :cascade do |t|
    t.integer  "instance_id",  limit: 2,   default: 0,  null: false
    t.datetime "entry_time",                            null: false
    t.integer  "command_type", limit: 2,   default: 0,  null: false
    t.string   "command_name", limit: 128, default: "", null: false
    t.string   "command_args", limit: 255, default: "", null: false
  end

  create_table "nagios_flappinghistory", primary_key: "flappinghistory_id", force: :cascade do |t|
    t.integer  "instance_id",          limit: 2,  default: 0,   null: false
    t.datetime "event_time",                                    null: false
    t.integer  "event_time_usec",      limit: 4,  default: 0,   null: false
    t.integer  "event_type",           limit: 2,  default: 0,   null: false
    t.integer  "reason_type",          limit: 2,  default: 0,   null: false
    t.integer  "flapping_type",        limit: 2,  default: 0,   null: false
    t.integer  "object_id",            limit: 4,  default: 0,   null: false
    t.float    "percent_state_change", limit: 53, default: 0.0, null: false
    t.float    "low_threshold",        limit: 53, default: 0.0, null: false
    t.float    "high_threshold",       limit: 53, default: 0.0, null: false
    t.datetime "comment_time",                                  null: false
    t.integer  "internal_comment_id",  limit: 4,  default: 0,   null: false
  end

  create_table "nagios_host_contactgroups", primary_key: "host_contactgroup_id", force: :cascade do |t|
    t.integer "instance_id",            limit: 2, default: 0, null: false
    t.integer "host_id",                limit: 4, default: 0, null: false
    t.integer "contactgroup_object_id", limit: 4, default: 0, null: false
  end

  add_index "nagios_host_contactgroups", ["host_id", "contactgroup_object_id"], name: "instance_id", unique: true, using: :btree

  create_table "nagios_host_contacts", primary_key: "host_contact_id", force: :cascade do |t|
    t.integer "instance_id",       limit: 2, default: 0, null: false
    t.integer "host_id",           limit: 4, default: 0, null: false
    t.integer "contact_object_id", limit: 4, default: 0, null: false
  end

  add_index "nagios_host_contacts", ["instance_id", "host_id", "contact_object_id"], name: "instance_id", unique: true, using: :btree

  create_table "nagios_host_parenthosts", primary_key: "host_parenthost_id", force: :cascade do |t|
    t.integer "instance_id",           limit: 2, default: 0, null: false
    t.integer "host_id",               limit: 4, default: 0, null: false
    t.integer "parent_host_object_id", limit: 4, default: 0, null: false
  end

  add_index "nagios_host_parenthosts", ["host_id", "parent_host_object_id"], name: "instance_id", unique: true, using: :btree

  create_table "nagios_hostchecks", primary_key: "hostcheck_id", force: :cascade do |t|
    t.integer  "instance_id",           limit: 2,     default: 0,   null: false
    t.integer  "host_object_id",        limit: 4,     default: 0,   null: false
    t.integer  "check_type",            limit: 2,     default: 0,   null: false
    t.integer  "is_raw_check",          limit: 2,     default: 0,   null: false
    t.integer  "current_check_attempt", limit: 2,     default: 0,   null: false
    t.integer  "max_check_attempts",    limit: 2,     default: 0,   null: false
    t.integer  "state",                 limit: 2,     default: 0,   null: false
    t.integer  "state_type",            limit: 2,     default: 0,   null: false
    t.datetime "start_time",                                        null: false
    t.integer  "start_time_usec",       limit: 4,     default: 0,   null: false
    t.datetime "end_time",                                          null: false
    t.integer  "end_time_usec",         limit: 4,     default: 0,   null: false
    t.integer  "command_object_id",     limit: 4,     default: 0,   null: false
    t.string   "command_args",          limit: 255,   default: "",  null: false
    t.string   "command_line",          limit: 255,   default: "",  null: false
    t.integer  "timeout",               limit: 2,     default: 0,   null: false
    t.integer  "early_timeout",         limit: 2,     default: 0,   null: false
    t.float    "execution_time",        limit: 53,    default: 0.0, null: false
    t.float    "latency",               limit: 53,    default: 0.0, null: false
    t.integer  "return_code",           limit: 2,     default: 0,   null: false
    t.string   "output",                limit: 255,   default: "",  null: false
    t.text     "long_output",           limit: 65535,               null: false
    t.text     "perfdata",              limit: 65535,               null: false
  end

  add_index "nagios_hostchecks", ["instance_id", "host_object_id", "start_time", "start_time_usec"], name: "instance_id", unique: true, using: :btree

  create_table "nagios_hostdependencies", primary_key: "hostdependency_id", force: :cascade do |t|
    t.integer "instance_id",              limit: 2, default: 0, null: false
    t.integer "config_type",              limit: 2, default: 0, null: false
    t.integer "host_object_id",           limit: 4, default: 0, null: false
    t.integer "dependent_host_object_id", limit: 4, default: 0, null: false
    t.integer "dependency_type",          limit: 2, default: 0, null: false
    t.integer "inherits_parent",          limit: 2, default: 0, null: false
    t.integer "timeperiod_object_id",     limit: 4, default: 0, null: false
    t.integer "fail_on_up",               limit: 2, default: 0, null: false
    t.integer "fail_on_down",             limit: 2, default: 0, null: false
    t.integer "fail_on_unreachable",      limit: 2, default: 0, null: false
  end

  add_index "nagios_hostdependencies", ["instance_id", "config_type", "host_object_id", "dependent_host_object_id", "dependency_type", "inherits_parent", "fail_on_up", "fail_on_down", "fail_on_unreachable"], name: "instance_id", unique: true, using: :btree

  create_table "nagios_hostescalation_contactgroups", primary_key: "hostescalation_contactgroup_id", force: :cascade do |t|
    t.integer "instance_id",            limit: 2, default: 0, null: false
    t.integer "hostescalation_id",      limit: 4, default: 0, null: false
    t.integer "contactgroup_object_id", limit: 4, default: 0, null: false
  end

  add_index "nagios_hostescalation_contactgroups", ["hostescalation_id", "contactgroup_object_id"], name: "instance_id", unique: true, using: :btree

  create_table "nagios_hostescalation_contacts", primary_key: "hostescalation_contact_id", force: :cascade do |t|
    t.integer "instance_id",       limit: 2, default: 0, null: false
    t.integer "hostescalation_id", limit: 4, default: 0, null: false
    t.integer "contact_object_id", limit: 4, default: 0, null: false
  end

  add_index "nagios_hostescalation_contacts", ["instance_id", "hostescalation_id", "contact_object_id"], name: "instance_id", unique: true, using: :btree

  create_table "nagios_hostescalations", primary_key: "hostescalation_id", force: :cascade do |t|
    t.integer "instance_id",             limit: 2,  default: 0,   null: false
    t.integer "config_type",             limit: 2,  default: 0,   null: false
    t.integer "host_object_id",          limit: 4,  default: 0,   null: false
    t.integer "timeperiod_object_id",    limit: 4,  default: 0,   null: false
    t.integer "first_notification",      limit: 2,  default: 0,   null: false
    t.integer "last_notification",       limit: 2,  default: 0,   null: false
    t.float   "notification_interval",   limit: 53, default: 0.0, null: false
    t.integer "escalate_on_recovery",    limit: 2,  default: 0,   null: false
    t.integer "escalate_on_down",        limit: 2,  default: 0,   null: false
    t.integer "escalate_on_unreachable", limit: 2,  default: 0,   null: false
  end

  add_index "nagios_hostescalations", ["instance_id", "config_type", "host_object_id", "timeperiod_object_id", "first_notification", "last_notification"], name: "instance_id", unique: true, using: :btree

  create_table "nagios_hostgroup_members", primary_key: "hostgroup_member_id", force: :cascade do |t|
    t.integer "instance_id",    limit: 2, default: 0, null: false
    t.integer "hostgroup_id",   limit: 4, default: 0, null: false
    t.integer "host_object_id", limit: 4, default: 0, null: false
  end

  add_index "nagios_hostgroup_members", ["hostgroup_id", "host_object_id"], name: "instance_id", unique: true, using: :btree

  create_table "nagios_hostgroups", primary_key: "hostgroup_id", force: :cascade do |t|
    t.integer "instance_id",         limit: 2,   default: 0,  null: false
    t.integer "config_type",         limit: 2,   default: 0,  null: false
    t.integer "hostgroup_object_id", limit: 4,   default: 0,  null: false
    t.string  "alias",               limit: 255, default: "", null: false
  end

  add_index "nagios_hostgroups", ["instance_id", "hostgroup_object_id"], name: "instance_id", unique: true, using: :btree

  create_table "nagios_hosts", primary_key: "host_id", force: :cascade do |t|
    t.integer "instance_id",                       limit: 2,   default: 0,   null: false
    t.integer "config_type",                       limit: 2,   default: 0,   null: false
    t.integer "host_object_id",                    limit: 4,   default: 0,   null: false
    t.string  "alias",                             limit: 64,  default: "",  null: false
    t.string  "display_name",                      limit: 64,  default: "",  null: false
    t.string  "address",                           limit: 128, default: "",  null: false
    t.integer "check_command_object_id",           limit: 4,   default: 0,   null: false
    t.string  "check_command_args",                limit: 255, default: "",  null: false
    t.integer "eventhandler_command_object_id",    limit: 4,   default: 0,   null: false
    t.string  "eventhandler_command_args",         limit: 255, default: "",  null: false
    t.integer "notification_timeperiod_object_id", limit: 4,   default: 0,   null: false
    t.integer "check_timeperiod_object_id",        limit: 4,   default: 0,   null: false
    t.string  "failure_prediction_options",        limit: 64,  default: "",  null: false
    t.float   "check_interval",                    limit: 53,  default: 0.0, null: false
    t.float   "retry_interval",                    limit: 53,  default: 0.0, null: false
    t.integer "max_check_attempts",                limit: 2,   default: 0,   null: false
    t.float   "first_notification_delay",          limit: 53,  default: 0.0, null: false
    t.float   "notification_interval",             limit: 53,  default: 0.0, null: false
    t.integer "notify_on_down",                    limit: 2,   default: 0,   null: false
    t.integer "notify_on_unreachable",             limit: 2,   default: 0,   null: false
    t.integer "notify_on_recovery",                limit: 2,   default: 0,   null: false
    t.integer "notify_on_flapping",                limit: 2,   default: 0,   null: false
    t.integer "notify_on_downtime",                limit: 2,   default: 0,   null: false
    t.integer "stalk_on_up",                       limit: 2,   default: 0,   null: false
    t.integer "stalk_on_down",                     limit: 2,   default: 0,   null: false
    t.integer "stalk_on_unreachable",              limit: 2,   default: 0,   null: false
    t.integer "flap_detection_enabled",            limit: 2,   default: 0,   null: false
    t.integer "flap_detection_on_up",              limit: 2,   default: 0,   null: false
    t.integer "flap_detection_on_down",            limit: 2,   default: 0,   null: false
    t.integer "flap_detection_on_unreachable",     limit: 2,   default: 0,   null: false
    t.float   "low_flap_threshold",                limit: 53,  default: 0.0, null: false
    t.float   "high_flap_threshold",               limit: 53,  default: 0.0, null: false
    t.integer "process_performance_data",          limit: 2,   default: 0,   null: false
    t.integer "freshness_checks_enabled",          limit: 2,   default: 0,   null: false
    t.integer "freshness_threshold",               limit: 2,   default: 0,   null: false
    t.integer "passive_checks_enabled",            limit: 2,   default: 0,   null: false
    t.integer "event_handler_enabled",             limit: 2,   default: 0,   null: false
    t.integer "active_checks_enabled",             limit: 2,   default: 0,   null: false
    t.integer "retain_status_information",         limit: 2,   default: 0,   null: false
    t.integer "retain_nonstatus_information",      limit: 2,   default: 0,   null: false
    t.integer "notifications_enabled",             limit: 2,   default: 0,   null: false
    t.integer "obsess_over_host",                  limit: 2,   default: 0,   null: false
    t.integer "failure_prediction_enabled",        limit: 2,   default: 0,   null: false
    t.string  "notes",                             limit: 255, default: "",  null: false
    t.string  "notes_url",                         limit: 255, default: "",  null: false
    t.string  "action_url",                        limit: 255, default: "",  null: false
    t.string  "icon_image",                        limit: 255, default: "",  null: false
    t.string  "icon_image_alt",                    limit: 255, default: "",  null: false
    t.string  "vrml_image",                        limit: 255, default: "",  null: false
    t.string  "statusmap_image",                   limit: 255, default: "",  null: false
    t.integer "have_2d_coords",                    limit: 2,   default: 0,   null: false
    t.integer "x_2d",                              limit: 2,   default: 0,   null: false
    t.integer "y_2d",                              limit: 2,   default: 0,   null: false
    t.integer "have_3d_coords",                    limit: 2,   default: 0,   null: false
    t.float   "x_3d",                              limit: 53,  default: 0.0, null: false
    t.float   "y_3d",                              limit: 53,  default: 0.0, null: false
    t.float   "z_3d",                              limit: 53,  default: 0.0, null: false
  end

  add_index "nagios_hosts", ["host_object_id"], name: "host_object_id", using: :btree
  add_index "nagios_hosts", ["instance_id", "config_type", "host_object_id"], name: "instance_id", unique: true, using: :btree

  create_table "nagios_hoststatus", primary_key: "hoststatus_id", force: :cascade do |t|
    t.integer  "instance_id",                   limit: 2,     default: 0,   null: false
    t.integer  "host_object_id",                limit: 4,     default: 0,   null: false
    t.datetime "status_update_time",                                        null: false
    t.string   "output",                        limit: 255,   default: "",  null: false
    t.text     "long_output",                   limit: 65535,               null: false
    t.text     "perfdata",                      limit: 65535,               null: false
    t.integer  "current_state",                 limit: 2,     default: 0,   null: false
    t.integer  "has_been_checked",              limit: 2,     default: 0,   null: false
    t.integer  "should_be_scheduled",           limit: 2,     default: 0,   null: false
    t.integer  "current_check_attempt",         limit: 2,     default: 0,   null: false
    t.integer  "max_check_attempts",            limit: 2,     default: 0,   null: false
    t.datetime "last_check",                                                null: false
    t.datetime "next_check",                                                null: false
    t.integer  "check_type",                    limit: 2,     default: 0,   null: false
    t.datetime "last_state_change",                                         null: false
    t.datetime "last_hard_state_change",                                    null: false
    t.integer  "last_hard_state",               limit: 2,     default: 0,   null: false
    t.datetime "last_time_up",                                              null: false
    t.datetime "last_time_down",                                            null: false
    t.datetime "last_time_unreachable",                                     null: false
    t.integer  "state_type",                    limit: 2,     default: 0,   null: false
    t.datetime "last_notification",                                         null: false
    t.datetime "next_notification",                                         null: false
    t.integer  "no_more_notifications",         limit: 2,     default: 0,   null: false
    t.integer  "notifications_enabled",         limit: 2,     default: 0,   null: false
    t.integer  "problem_has_been_acknowledged", limit: 2,     default: 0,   null: false
    t.integer  "acknowledgement_type",          limit: 2,     default: 0,   null: false
    t.integer  "current_notification_number",   limit: 2,     default: 0,   null: false
    t.integer  "passive_checks_enabled",        limit: 2,     default: 0,   null: false
    t.integer  "active_checks_enabled",         limit: 2,     default: 0,   null: false
    t.integer  "event_handler_enabled",         limit: 2,     default: 0,   null: false
    t.integer  "flap_detection_enabled",        limit: 2,     default: 0,   null: false
    t.integer  "is_flapping",                   limit: 2,     default: 0,   null: false
    t.float    "percent_state_change",          limit: 53,    default: 0.0, null: false
    t.float    "latency",                       limit: 53,    default: 0.0, null: false
    t.float    "execution_time",                limit: 53,    default: 0.0, null: false
    t.integer  "scheduled_downtime_depth",      limit: 2,     default: 0,   null: false
    t.integer  "failure_prediction_enabled",    limit: 2,     default: 0,   null: false
    t.integer  "process_performance_data",      limit: 2,     default: 0,   null: false
    t.integer  "obsess_over_host",              limit: 2,     default: 0,   null: false
    t.integer  "modified_host_attributes",      limit: 4,     default: 0,   null: false
    t.string   "event_handler",                 limit: 255,   default: "",  null: false
    t.string   "check_command",                 limit: 255,   default: "",  null: false
    t.float    "normal_check_interval",         limit: 53,    default: 0.0, null: false
    t.float    "retry_check_interval",          limit: 53,    default: 0.0, null: false
    t.integer  "check_timeperiod_object_id",    limit: 4,     default: 0,   null: false
  end

  add_index "nagios_hoststatus", ["active_checks_enabled"], name: "active_checks_enabled", using: :btree
  add_index "nagios_hoststatus", ["check_type"], name: "check_type", using: :btree
  add_index "nagios_hoststatus", ["current_state"], name: "current_state", using: :btree
  add_index "nagios_hoststatus", ["event_handler_enabled"], name: "event_handler_enabled", using: :btree
  add_index "nagios_hoststatus", ["execution_time"], name: "execution_time", using: :btree
  add_index "nagios_hoststatus", ["flap_detection_enabled"], name: "flap_detection_enabled", using: :btree
  add_index "nagios_hoststatus", ["host_object_id"], name: "object_id", unique: true, using: :btree
  add_index "nagios_hoststatus", ["instance_id"], name: "instance_id", using: :btree
  add_index "nagios_hoststatus", ["is_flapping"], name: "is_flapping", using: :btree
  add_index "nagios_hoststatus", ["last_state_change"], name: "last_state_change", using: :btree
  add_index "nagios_hoststatus", ["latency"], name: "latency", using: :btree
  add_index "nagios_hoststatus", ["notifications_enabled"], name: "notifications_enabled", using: :btree
  add_index "nagios_hoststatus", ["passive_checks_enabled"], name: "passive_checks_enabled", using: :btree
  add_index "nagios_hoststatus", ["percent_state_change"], name: "percent_state_change", using: :btree
  add_index "nagios_hoststatus", ["problem_has_been_acknowledged"], name: "problem_has_been_acknowledged", using: :btree
  add_index "nagios_hoststatus", ["scheduled_downtime_depth"], name: "scheduled_downtime_depth", using: :btree
  add_index "nagios_hoststatus", ["state_type"], name: "state_type", using: :btree
  add_index "nagios_hoststatus", ["status_update_time"], name: "status_update_time", using: :btree

  create_table "nagios_instances", primary_key: "instance_id", force: :cascade do |t|
    t.string "instance_name",        limit: 64,  default: "", null: false
    t.string "instance_description", limit: 128, default: "", null: false
  end

  create_table "nagios_logentries", primary_key: "logentry_id", force: :cascade do |t|
    t.integer  "instance_id",             limit: 4,   default: 0,  null: false
    t.datetime "logentry_time",                                    null: false
    t.datetime "entry_time",                                       null: false
    t.integer  "entry_time_usec",         limit: 4,   default: 0,  null: false
    t.integer  "logentry_type",           limit: 4,   default: 0,  null: false
    t.string   "logentry_data",           limit: 255, default: "", null: false
    t.integer  "realtime_data",           limit: 2,   default: 0,  null: false
    t.integer  "inferred_data_extracted", limit: 2,   default: 0,  null: false
  end

  create_table "nagios_notifications", primary_key: "notification_id", force: :cascade do |t|
    t.integer  "instance_id",         limit: 2,     default: 0,  null: false
    t.integer  "notification_type",   limit: 2,     default: 0,  null: false
    t.integer  "notification_reason", limit: 2,     default: 0,  null: false
    t.integer  "object_id",           limit: 4,     default: 0,  null: false
    t.datetime "start_time",                                     null: false
    t.integer  "start_time_usec",     limit: 4,     default: 0,  null: false
    t.datetime "end_time",                                       null: false
    t.integer  "end_time_usec",       limit: 4,     default: 0,  null: false
    t.integer  "state",               limit: 2,     default: 0,  null: false
    t.string   "output",              limit: 255,   default: "", null: false
    t.text     "long_output",         limit: 65535,              null: false
    t.integer  "escalated",           limit: 2,     default: 0,  null: false
    t.integer  "contacts_notified",   limit: 2,     default: 0,  null: false
  end

  add_index "nagios_notifications", ["instance_id", "object_id", "start_time", "start_time_usec"], name: "instance_id", unique: true, using: :btree

  create_table "nagios_objects", primary_key: "object_id", force: :cascade do |t|
    t.integer "instance_id",   limit: 2,   default: 0,  null: false
    t.integer "objecttype_id", limit: 2,   default: 0,  null: false
    t.string  "name1",         limit: 128, default: "", null: false
    t.string  "name2",         limit: 128
    t.integer "is_active",     limit: 2,   default: 0,  null: false
  end

  add_index "nagios_objects", ["objecttype_id", "name1", "name2"], name: "objecttype_id", using: :btree

  create_table "nagios_processevents", primary_key: "processevent_id", force: :cascade do |t|
    t.integer  "instance_id",     limit: 2,  default: 0,  null: false
    t.integer  "event_type",      limit: 2,  default: 0,  null: false
    t.datetime "event_time",                              null: false
    t.integer  "event_time_usec", limit: 4,  default: 0,  null: false
    t.integer  "process_id",      limit: 4,  default: 0,  null: false
    t.string   "program_name",    limit: 16, default: "", null: false
    t.string   "program_version", limit: 20, default: "", null: false
    t.string   "program_date",    limit: 10, default: "", null: false
  end

  create_table "nagios_programstatus", primary_key: "programstatus_id", force: :cascade do |t|
    t.integer  "instance_id",                    limit: 2,   default: 0,  null: false
    t.datetime "status_update_time",                                      null: false
    t.datetime "program_start_time",                                      null: false
    t.datetime "program_end_time",                                        null: false
    t.integer  "is_currently_running",           limit: 2,   default: 0,  null: false
    t.integer  "process_id",                     limit: 4,   default: 0,  null: false
    t.integer  "daemon_mode",                    limit: 2,   default: 0,  null: false
    t.datetime "last_command_check",                                      null: false
    t.datetime "last_log_rotation",                                       null: false
    t.integer  "notifications_enabled",          limit: 2,   default: 0,  null: false
    t.integer  "active_service_checks_enabled",  limit: 2,   default: 0,  null: false
    t.integer  "passive_service_checks_enabled", limit: 2,   default: 0,  null: false
    t.integer  "active_host_checks_enabled",     limit: 2,   default: 0,  null: false
    t.integer  "passive_host_checks_enabled",    limit: 2,   default: 0,  null: false
    t.integer  "event_handlers_enabled",         limit: 2,   default: 0,  null: false
    t.integer  "flap_detection_enabled",         limit: 2,   default: 0,  null: false
    t.integer  "failure_prediction_enabled",     limit: 2,   default: 0,  null: false
    t.integer  "process_performance_data",       limit: 2,   default: 0,  null: false
    t.integer  "obsess_over_hosts",              limit: 2,   default: 0,  null: false
    t.integer  "obsess_over_services",           limit: 2,   default: 0,  null: false
    t.integer  "modified_host_attributes",       limit: 4,   default: 0,  null: false
    t.integer  "modified_service_attributes",    limit: 4,   default: 0,  null: false
    t.string   "global_host_event_handler",      limit: 255, default: "", null: false
    t.string   "global_service_event_handler",   limit: 255, default: "", null: false
  end

  add_index "nagios_programstatus", ["instance_id"], name: "instance_id", unique: true, using: :btree

  create_table "nagios_runtimevariables", primary_key: "runtimevariable_id", force: :cascade do |t|
    t.integer "instance_id", limit: 2,   default: 0,  null: false
    t.string  "varname",     limit: 64,  default: "", null: false
    t.string  "varvalue",    limit: 255, default: "", null: false
  end

  add_index "nagios_runtimevariables", ["instance_id", "varname"], name: "instance_id", unique: true, using: :btree

  create_table "nagios_scheduleddowntime", primary_key: "scheduleddowntime_id", force: :cascade do |t|
    t.integer  "instance_id",            limit: 2,   default: 0,  null: false
    t.integer  "downtime_type",          limit: 2,   default: 0,  null: false
    t.integer  "object_id",              limit: 4,   default: 0,  null: false
    t.datetime "entry_time",                                      null: false
    t.string   "author_name",            limit: 64,  default: "", null: false
    t.string   "comment_data",           limit: 255, default: "", null: false
    t.integer  "internal_downtime_id",   limit: 4,   default: 0,  null: false
    t.integer  "triggered_by_id",        limit: 4,   default: 0,  null: false
    t.integer  "is_fixed",               limit: 2,   default: 0,  null: false
    t.integer  "duration",               limit: 2,   default: 0,  null: false
    t.datetime "scheduled_start_time",                            null: false
    t.datetime "scheduled_end_time",                              null: false
    t.integer  "was_started",            limit: 2,   default: 0,  null: false
    t.datetime "actual_start_time",                               null: false
    t.integer  "actual_start_time_usec", limit: 4,   default: 0,  null: false
  end

  add_index "nagios_scheduleddowntime", ["instance_id", "object_id", "entry_time", "internal_downtime_id"], name: "instance_id", unique: true, using: :btree

  create_table "nagios_service_contactgroups", primary_key: "service_contactgroup_id", force: :cascade do |t|
    t.integer "instance_id",            limit: 2, default: 0, null: false
    t.integer "service_id",             limit: 4, default: 0, null: false
    t.integer "contactgroup_object_id", limit: 4, default: 0, null: false
  end

  add_index "nagios_service_contactgroups", ["service_id", "contactgroup_object_id"], name: "instance_id", unique: true, using: :btree

  create_table "nagios_service_contacts", primary_key: "service_contact_id", force: :cascade do |t|
    t.integer "instance_id",       limit: 2, default: 0, null: false
    t.integer "service_id",        limit: 4, default: 0, null: false
    t.integer "contact_object_id", limit: 4, default: 0, null: false
  end

  add_index "nagios_service_contacts", ["instance_id", "service_id", "contact_object_id"], name: "instance_id", unique: true, using: :btree

  create_table "nagios_servicechecks", primary_key: "servicecheck_id", force: :cascade do |t|
    t.integer  "instance_id",           limit: 2,     default: 0,   null: false
    t.integer  "service_object_id",     limit: 4,     default: 0,   null: false
    t.integer  "check_type",            limit: 2,     default: 0,   null: false
    t.integer  "current_check_attempt", limit: 2,     default: 0,   null: false
    t.integer  "max_check_attempts",    limit: 2,     default: 0,   null: false
    t.integer  "state",                 limit: 2,     default: 0,   null: false
    t.integer  "state_type",            limit: 2,     default: 0,   null: false
    t.datetime "start_time",                                        null: false
    t.integer  "start_time_usec",       limit: 4,     default: 0,   null: false
    t.datetime "end_time",                                          null: false
    t.integer  "end_time_usec",         limit: 4,     default: 0,   null: false
    t.integer  "command_object_id",     limit: 4,     default: 0,   null: false
    t.string   "command_args",          limit: 255,   default: "",  null: false
    t.string   "command_line",          limit: 255,   default: "",  null: false
    t.integer  "timeout",               limit: 2,     default: 0,   null: false
    t.integer  "early_timeout",         limit: 2,     default: 0,   null: false
    t.float    "execution_time",        limit: 53,    default: 0.0, null: false
    t.float    "latency",               limit: 53,    default: 0.0, null: false
    t.integer  "return_code",           limit: 2,     default: 0,   null: false
    t.string   "output",                limit: 255,   default: "",  null: false
    t.text     "long_output",           limit: 65535,               null: false
    t.text     "perfdata",              limit: 65535,               null: false
  end

  add_index "nagios_servicechecks", ["instance_id"], name: "instance_id", using: :btree
  add_index "nagios_servicechecks", ["service_object_id"], name: "service_object_id", using: :btree
  add_index "nagios_servicechecks", ["start_time"], name: "start_time", using: :btree

  create_table "nagios_servicedependencies", primary_key: "servicedependency_id", force: :cascade do |t|
    t.integer "instance_id",                 limit: 2, default: 0, null: false
    t.integer "config_type",                 limit: 2, default: 0, null: false
    t.integer "service_object_id",           limit: 4, default: 0, null: false
    t.integer "dependent_service_object_id", limit: 4, default: 0, null: false
    t.integer "dependency_type",             limit: 2, default: 0, null: false
    t.integer "inherits_parent",             limit: 2, default: 0, null: false
    t.integer "timeperiod_object_id",        limit: 4, default: 0, null: false
    t.integer "fail_on_ok",                  limit: 2, default: 0, null: false
    t.integer "fail_on_warning",             limit: 2, default: 0, null: false
    t.integer "fail_on_unknown",             limit: 2, default: 0, null: false
    t.integer "fail_on_critical",            limit: 2, default: 0, null: false
  end

  add_index "nagios_servicedependencies", ["instance_id", "config_type", "service_object_id", "dependent_service_object_id", "dependency_type", "inherits_parent", "fail_on_ok", "fail_on_warning", "fail_on_unknown", "fail_on_critical"], name: "instance_id", unique: true, using: :btree

  create_table "nagios_serviceescalation_contactgroups", primary_key: "serviceescalation_contactgroup_id", force: :cascade do |t|
    t.integer "instance_id",            limit: 2, default: 0, null: false
    t.integer "serviceescalation_id",   limit: 4, default: 0, null: false
    t.integer "contactgroup_object_id", limit: 4, default: 0, null: false
  end

  add_index "nagios_serviceescalation_contactgroups", ["serviceescalation_id", "contactgroup_object_id"], name: "instance_id", unique: true, using: :btree

  create_table "nagios_serviceescalation_contacts", primary_key: "serviceescalation_contact_id", force: :cascade do |t|
    t.integer "instance_id",          limit: 2, default: 0, null: false
    t.integer "serviceescalation_id", limit: 4, default: 0, null: false
    t.integer "contact_object_id",    limit: 4, default: 0, null: false
  end

  add_index "nagios_serviceescalation_contacts", ["instance_id", "serviceescalation_id", "contact_object_id"], name: "instance_id", unique: true, using: :btree

  create_table "nagios_serviceescalations", primary_key: "serviceescalation_id", force: :cascade do |t|
    t.integer "instance_id",           limit: 2,  default: 0,   null: false
    t.integer "config_type",           limit: 2,  default: 0,   null: false
    t.integer "service_object_id",     limit: 4,  default: 0,   null: false
    t.integer "timeperiod_object_id",  limit: 4,  default: 0,   null: false
    t.integer "first_notification",    limit: 2,  default: 0,   null: false
    t.integer "last_notification",     limit: 2,  default: 0,   null: false
    t.float   "notification_interval", limit: 53, default: 0.0, null: false
    t.integer "escalate_on_recovery",  limit: 2,  default: 0,   null: false
    t.integer "escalate_on_warning",   limit: 2,  default: 0,   null: false
    t.integer "escalate_on_unknown",   limit: 2,  default: 0,   null: false
    t.integer "escalate_on_critical",  limit: 2,  default: 0,   null: false
  end

  add_index "nagios_serviceescalations", ["instance_id", "config_type", "service_object_id", "timeperiod_object_id", "first_notification", "last_notification"], name: "instance_id", unique: true, using: :btree

  create_table "nagios_servicegroup_members", primary_key: "servicegroup_member_id", force: :cascade do |t|
    t.integer "instance_id",       limit: 2, default: 0, null: false
    t.integer "servicegroup_id",   limit: 4, default: 0, null: false
    t.integer "service_object_id", limit: 4, default: 0, null: false
  end

  add_index "nagios_servicegroup_members", ["servicegroup_id", "service_object_id"], name: "instance_id", unique: true, using: :btree

  create_table "nagios_servicegroups", primary_key: "servicegroup_id", force: :cascade do |t|
    t.integer "instance_id",            limit: 2,   default: 0,  null: false
    t.integer "config_type",            limit: 2,   default: 0,  null: false
    t.integer "servicegroup_object_id", limit: 4,   default: 0,  null: false
    t.string  "alias",                  limit: 255, default: "", null: false
  end

  add_index "nagios_servicegroups", ["instance_id", "config_type", "servicegroup_object_id"], name: "instance_id", unique: true, using: :btree

  create_table "nagios_services", primary_key: "service_id", force: :cascade do |t|
    t.integer "instance_id",                       limit: 2,   default: 0,   null: false
    t.integer "config_type",                       limit: 2,   default: 0,   null: false
    t.integer "host_object_id",                    limit: 4,   default: 0,   null: false
    t.integer "service_object_id",                 limit: 4,   default: 0,   null: false
    t.string  "display_name",                      limit: 64,  default: "",  null: false
    t.integer "check_command_object_id",           limit: 4,   default: 0,   null: false
    t.string  "check_command_args",                limit: 255, default: "",  null: false
    t.integer "eventhandler_command_object_id",    limit: 4,   default: 0,   null: false
    t.string  "eventhandler_command_args",         limit: 255, default: "",  null: false
    t.integer "notification_timeperiod_object_id", limit: 4,   default: 0,   null: false
    t.integer "check_timeperiod_object_id",        limit: 4,   default: 0,   null: false
    t.string  "failure_prediction_options",        limit: 64,  default: "",  null: false
    t.float   "check_interval",                    limit: 53,  default: 0.0, null: false
    t.float   "retry_interval",                    limit: 53,  default: 0.0, null: false
    t.integer "max_check_attempts",                limit: 2,   default: 0,   null: false
    t.float   "first_notification_delay",          limit: 53,  default: 0.0, null: false
    t.float   "notification_interval",             limit: 53,  default: 0.0, null: false
    t.integer "notify_on_warning",                 limit: 2,   default: 0,   null: false
    t.integer "notify_on_unknown",                 limit: 2,   default: 0,   null: false
    t.integer "notify_on_critical",                limit: 2,   default: 0,   null: false
    t.integer "notify_on_recovery",                limit: 2,   default: 0,   null: false
    t.integer "notify_on_flapping",                limit: 2,   default: 0,   null: false
    t.integer "notify_on_downtime",                limit: 2,   default: 0,   null: false
    t.integer "stalk_on_ok",                       limit: 2,   default: 0,   null: false
    t.integer "stalk_on_warning",                  limit: 2,   default: 0,   null: false
    t.integer "stalk_on_unknown",                  limit: 2,   default: 0,   null: false
    t.integer "stalk_on_critical",                 limit: 2,   default: 0,   null: false
    t.integer "is_volatile",                       limit: 2,   default: 0,   null: false
    t.integer "flap_detection_enabled",            limit: 2,   default: 0,   null: false
    t.integer "flap_detection_on_ok",              limit: 2,   default: 0,   null: false
    t.integer "flap_detection_on_warning",         limit: 2,   default: 0,   null: false
    t.integer "flap_detection_on_unknown",         limit: 2,   default: 0,   null: false
    t.integer "flap_detection_on_critical",        limit: 2,   default: 0,   null: false
    t.float   "low_flap_threshold",                limit: 53,  default: 0.0, null: false
    t.float   "high_flap_threshold",               limit: 53,  default: 0.0, null: false
    t.integer "process_performance_data",          limit: 2,   default: 0,   null: false
    t.integer "freshness_checks_enabled",          limit: 2,   default: 0,   null: false
    t.integer "freshness_threshold",               limit: 2,   default: 0,   null: false
    t.integer "passive_checks_enabled",            limit: 2,   default: 0,   null: false
    t.integer "event_handler_enabled",             limit: 2,   default: 0,   null: false
    t.integer "active_checks_enabled",             limit: 2,   default: 0,   null: false
    t.integer "retain_status_information",         limit: 2,   default: 0,   null: false
    t.integer "retain_nonstatus_information",      limit: 2,   default: 0,   null: false
    t.integer "notifications_enabled",             limit: 2,   default: 0,   null: false
    t.integer "obsess_over_service",               limit: 2,   default: 0,   null: false
    t.integer "failure_prediction_enabled",        limit: 2,   default: 0,   null: false
    t.string  "notes",                             limit: 255, default: "",  null: false
    t.string  "notes_url",                         limit: 255, default: "",  null: false
    t.string  "action_url",                        limit: 255, default: "",  null: false
    t.string  "icon_image",                        limit: 255, default: "",  null: false
    t.string  "icon_image_alt",                    limit: 255, default: "",  null: false
  end

  add_index "nagios_services", ["instance_id", "config_type", "service_object_id"], name: "instance_id", unique: true, using: :btree
  add_index "nagios_services", ["service_object_id"], name: "service_object_id", using: :btree

  create_table "nagios_servicestatus", primary_key: "servicestatus_id", force: :cascade do |t|
    t.integer  "instance_id",                   limit: 2,     default: 0,   null: false
    t.integer  "service_object_id",             limit: 4,     default: 0,   null: false
    t.datetime "status_update_time",                                        null: false
    t.string   "output",                        limit: 255,   default: "",  null: false
    t.text     "long_output",                   limit: 65535,               null: false
    t.text     "perfdata",                      limit: 65535,               null: false
    t.integer  "current_state",                 limit: 2,     default: 0,   null: false
    t.integer  "has_been_checked",              limit: 2,     default: 0,   null: false
    t.integer  "should_be_scheduled",           limit: 2,     default: 0,   null: false
    t.integer  "current_check_attempt",         limit: 2,     default: 0,   null: false
    t.integer  "max_check_attempts",            limit: 2,     default: 0,   null: false
    t.datetime "last_check",                                                null: false
    t.datetime "next_check",                                                null: false
    t.integer  "check_type",                    limit: 2,     default: 0,   null: false
    t.datetime "last_state_change",                                         null: false
    t.datetime "last_hard_state_change",                                    null: false
    t.integer  "last_hard_state",               limit: 2,     default: 0,   null: false
    t.datetime "last_time_ok",                                              null: false
    t.datetime "last_time_warning",                                         null: false
    t.datetime "last_time_unknown",                                         null: false
    t.datetime "last_time_critical",                                        null: false
    t.integer  "state_type",                    limit: 2,     default: 0,   null: false
    t.datetime "last_notification",                                         null: false
    t.datetime "next_notification",                                         null: false
    t.integer  "no_more_notifications",         limit: 2,     default: 0,   null: false
    t.integer  "notifications_enabled",         limit: 2,     default: 0,   null: false
    t.integer  "problem_has_been_acknowledged", limit: 2,     default: 0,   null: false
    t.integer  "acknowledgement_type",          limit: 2,     default: 0,   null: false
    t.integer  "current_notification_number",   limit: 2,     default: 0,   null: false
    t.integer  "passive_checks_enabled",        limit: 2,     default: 0,   null: false
    t.integer  "active_checks_enabled",         limit: 2,     default: 0,   null: false
    t.integer  "event_handler_enabled",         limit: 2,     default: 0,   null: false
    t.integer  "flap_detection_enabled",        limit: 2,     default: 0,   null: false
    t.integer  "is_flapping",                   limit: 2,     default: 0,   null: false
    t.float    "percent_state_change",          limit: 53,    default: 0.0, null: false
    t.float    "latency",                       limit: 53,    default: 0.0, null: false
    t.float    "execution_time",                limit: 53,    default: 0.0, null: false
    t.integer  "scheduled_downtime_depth",      limit: 2,     default: 0,   null: false
    t.integer  "failure_prediction_enabled",    limit: 2,     default: 0,   null: false
    t.integer  "process_performance_data",      limit: 2,     default: 0,   null: false
    t.integer  "obsess_over_service",           limit: 2,     default: 0,   null: false
    t.integer  "modified_service_attributes",   limit: 4,     default: 0,   null: false
    t.string   "event_handler",                 limit: 255,   default: "",  null: false
    t.string   "check_command",                 limit: 255,   default: "",  null: false
    t.float    "normal_check_interval",         limit: 53,    default: 0.0, null: false
    t.float    "retry_check_interval",          limit: 53,    default: 0.0, null: false
    t.integer  "check_timeperiod_object_id",    limit: 4,     default: 0,   null: false
  end

  add_index "nagios_servicestatus", ["active_checks_enabled"], name: "active_checks_enabled", using: :btree
  add_index "nagios_servicestatus", ["check_type"], name: "check_type", using: :btree
  add_index "nagios_servicestatus", ["current_state"], name: "current_state", using: :btree
  add_index "nagios_servicestatus", ["event_handler_enabled"], name: "event_handler_enabled", using: :btree
  add_index "nagios_servicestatus", ["execution_time"], name: "execution_time", using: :btree
  add_index "nagios_servicestatus", ["flap_detection_enabled"], name: "flap_detection_enabled", using: :btree
  add_index "nagios_servicestatus", ["instance_id"], name: "instance_id", using: :btree
  add_index "nagios_servicestatus", ["is_flapping"], name: "is_flapping", using: :btree
  add_index "nagios_servicestatus", ["last_state_change"], name: "last_state_change", using: :btree
  add_index "nagios_servicestatus", ["latency"], name: "latency", using: :btree
  add_index "nagios_servicestatus", ["notifications_enabled"], name: "notifications_enabled", using: :btree
  add_index "nagios_servicestatus", ["passive_checks_enabled"], name: "passive_checks_enabled", using: :btree
  add_index "nagios_servicestatus", ["percent_state_change"], name: "percent_state_change", using: :btree
  add_index "nagios_servicestatus", ["problem_has_been_acknowledged"], name: "problem_has_been_acknowledged", using: :btree
  add_index "nagios_servicestatus", ["scheduled_downtime_depth"], name: "scheduled_downtime_depth", using: :btree
  add_index "nagios_servicestatus", ["service_object_id"], name: "object_id", unique: true, using: :btree
  add_index "nagios_servicestatus", ["state_type"], name: "state_type", using: :btree
  add_index "nagios_servicestatus", ["status_update_time"], name: "status_update_time", using: :btree

  create_table "nagios_statehistory", primary_key: "statehistory_id", force: :cascade do |t|
    t.integer  "instance_id",           limit: 2,     default: 0,  null: false
    t.datetime "state_time",                                       null: false
    t.integer  "state_time_usec",       limit: 4,     default: 0,  null: false
    t.integer  "object_id",             limit: 4,     default: 0,  null: false
    t.integer  "state_change",          limit: 2,     default: 0,  null: false
    t.integer  "state",                 limit: 2,     default: 0,  null: false
    t.integer  "state_type",            limit: 2,     default: 0,  null: false
    t.integer  "current_check_attempt", limit: 2,     default: 0,  null: false
    t.integer  "max_check_attempts",    limit: 2,     default: 0,  null: false
    t.integer  "last_state",            limit: 2,     default: -1, null: false
    t.integer  "last_hard_state",       limit: 2,     default: -1, null: false
    t.string   "output",                limit: 255,   default: "", null: false
    t.text     "long_output",           limit: 65535,              null: false
  end

  create_table "nagios_systemcommands", primary_key: "systemcommand_id", force: :cascade do |t|
    t.integer  "instance_id",     limit: 2,     default: 0,   null: false
    t.datetime "start_time",                                  null: false
    t.integer  "start_time_usec", limit: 4,     default: 0,   null: false
    t.datetime "end_time",                                    null: false
    t.integer  "end_time_usec",   limit: 4,     default: 0,   null: false
    t.string   "command_line",    limit: 255,   default: "",  null: false
    t.integer  "timeout",         limit: 2,     default: 0,   null: false
    t.integer  "early_timeout",   limit: 2,     default: 0,   null: false
    t.float    "execution_time",  limit: 53,    default: 0.0, null: false
    t.integer  "return_code",     limit: 2,     default: 0,   null: false
    t.string   "output",          limit: 255,   default: "",  null: false
    t.text     "long_output",     limit: 65535,               null: false
  end

  add_index "nagios_systemcommands", ["instance_id"], name: "instance_id", using: :btree
  add_index "nagios_systemcommands", ["start_time"], name: "start_time", using: :btree

  create_table "nagios_timedeventqueue", primary_key: "timedeventqueue_id", force: :cascade do |t|
    t.integer  "instance_id",      limit: 2, default: 0, null: false
    t.integer  "event_type",       limit: 2, default: 0, null: false
    t.datetime "queued_time",                            null: false
    t.integer  "queued_time_usec", limit: 4, default: 0, null: false
    t.datetime "scheduled_time",                         null: false
    t.integer  "recurring_event",  limit: 2, default: 0, null: false
    t.integer  "object_id",        limit: 4, default: 0, null: false
  end

  add_index "nagios_timedeventqueue", ["event_type"], name: "event_type", using: :btree
  add_index "nagios_timedeventqueue", ["instance_id"], name: "instance_id", using: :btree
  add_index "nagios_timedeventqueue", ["object_id"], name: "object_id", using: :btree
  add_index "nagios_timedeventqueue", ["scheduled_time"], name: "scheduled_time", using: :btree

  create_table "nagios_timedevents", primary_key: "timedevent_id", force: :cascade do |t|
    t.integer  "instance_id",        limit: 2, default: 0, null: false
    t.integer  "event_type",         limit: 2, default: 0, null: false
    t.datetime "queued_time",                              null: false
    t.integer  "queued_time_usec",   limit: 4, default: 0, null: false
    t.datetime "event_time",                               null: false
    t.integer  "event_time_usec",    limit: 4, default: 0, null: false
    t.datetime "scheduled_time",                           null: false
    t.integer  "recurring_event",    limit: 2, default: 0, null: false
    t.integer  "object_id",          limit: 4, default: 0, null: false
    t.datetime "deletion_time",                            null: false
    t.integer  "deletion_time_usec", limit: 4, default: 0, null: false
  end

  add_index "nagios_timedevents", ["event_type"], name: "event_type", using: :btree
  add_index "nagios_timedevents", ["instance_id"], name: "instance_id", using: :btree
  add_index "nagios_timedevents", ["object_id"], name: "object_id", using: :btree
  add_index "nagios_timedevents", ["scheduled_time"], name: "scheduled_time", using: :btree

  create_table "nagios_timeperiod_timeranges", primary_key: "timeperiod_timerange_id", force: :cascade do |t|
    t.integer "instance_id",   limit: 2, default: 0, null: false
    t.integer "timeperiod_id", limit: 4, default: 0, null: false
    t.integer "day",           limit: 2, default: 0, null: false
    t.integer "start_sec",     limit: 4, default: 0, null: false
    t.integer "end_sec",       limit: 4, default: 0, null: false
  end

  add_index "nagios_timeperiod_timeranges", ["timeperiod_id", "day", "start_sec", "end_sec"], name: "instance_id", unique: true, using: :btree

  create_table "nagios_timeperiods", primary_key: "timeperiod_id", force: :cascade do |t|
    t.integer "instance_id",          limit: 2,   default: 0,  null: false
    t.integer "config_type",          limit: 2,   default: 0,  null: false
    t.integer "timeperiod_object_id", limit: 4,   default: 0,  null: false
    t.string  "alias",                limit: 255, default: "", null: false
  end

  add_index "nagios_timeperiods", ["instance_id", "config_type", "timeperiod_object_id"], name: "instance_id", unique: true, using: :btree

  create_table "settings", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "value",      limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "settings", ["name"], name: "index_settings_on_name", unique: true, using: :btree

  create_table "user_groups", force: :cascade do |t|
    t.integer "user_id",  limit: 4
    t.integer "group_id", limit: 4
  end

  add_index "user_groups", ["group_id"], name: "index_user_groups_on_group_id", using: :btree
  add_index "user_groups", ["user_id"], name: "index_user_groups_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "encrypted_password",     limit: 255, default: "",    null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "admin",                              default: false
    t.string   "username",               limit: 255
  end

  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "uuids", force: :cascade do |t|
    t.string  "uuid",          limit: 255
    t.integer "uuidable_id",   limit: 4
    t.string  "uuidable_type", limit: 40
  end

  add_index "uuids", ["uuidable_id", "uuidable_type"], name: "index_uuids_on_uuidable_id_and_uuidable_type", using: :btree

  add_foreign_key "flag_categories", "events"
  add_foreign_key "flag_submissions", "flags"
  add_foreign_key "flag_submissions", "users"
  add_foreign_key "flags", "flag_categories"
  add_foreign_key "injects", "events"
  add_foreign_key "user_groups", "groups"
  add_foreign_key "user_groups", "users"
end
