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

ActiveRecord::Schema.define(version: 20140209120908) do

  create_table "domains", force: :cascade do |t|
    t.string   "pfam_acc",    limit: 255
    t.string   "pfam_id",     limit: 255
    t.string   "name",        limit: 255
    t.text     "description"
    t.string   "clan_id",     limit: 255
    t.string   "clan_acc",    limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "domains", ["clan_id"], name: "index_domains_on_clan_id"
  add_index "domains", ["name"], name: "index_domains_on_name"
  add_index "domains", ["pfam_id"], name: "index_domains_on_pfam_id"

  create_table "evidences", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "evidences", ["name"], name: "index_evidences_on_name"

  create_table "families", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "goterms", force: :cascade do |t|
    t.string   "go_term",    limit: 255
    t.string   "go_name",    limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "protein_has_domains", force: :cascade do |t|
    t.integer  "dom_in_prot_id"
    t.integer  "prot_in_dom_id"
    t.integer  "start_position"
    t.integer  "end_position"
    t.float    "evalue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "protein_has_domains", ["dom_in_prot_id"], name: "index_protein_has_domains_on_dom_in_prot_id"
  add_index "protein_has_domains", ["prot_in_dom_id", "start_position"], name: "index_protein_has_domains_on_prot_in_dom_id_and_start_position", unique: true
  add_index "protein_has_domains", ["prot_in_dom_id"], name: "index_protein_has_domains_on_prot_in_dom_id"

  create_table "proteins", force: :cascade do |t|
    t.string   "protein_accession", limit: 255
    t.text     "protein_sequence",              default: ""
    t.string   "name",              limit: 255
    t.integer  "taxon_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "evidence_id"
    t.integer  "family_id"
  end

  add_index "proteins", ["name"], name: "index_proteins_on_name"
  add_index "proteins", ["protein_accession"], name: "index_proteins_on_protein_accession", unique: true

  create_table "proteins_goterms", force: :cascade do |t|
    t.integer  "protein_id"
    t.integer  "goterm_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "proteins_goterms", ["protein_id", "goterm_id"], name: "index_proteins_goterms_on_protein_id_and_goterm_id", unique: true

  create_table "taxa", force: :cascade do |t|
    t.string   "taxon_name",  limit: 255
    t.integer  "NCBIid"
    t.text     "NCBIlineage"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "taxa", ["taxon_name"], name: "index_taxa_on_taxon_name"

end
