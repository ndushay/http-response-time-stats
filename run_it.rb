$: << 'lib'

ckeys = [
  # smaller
  {'407209' => 'SAL3'}, # Desert Tortoise proceedings (~20 items), SAL3
  {'1971562' => 'SAL3'}, # Beethoven Symphony score; about 10 items, SAL3
  {'2020090' => 'SPEC-COLL'}, # New American Cookery - 1 item, SPEC
  # huge records
  {'4332640' => 'SPEC-COLL'}, # Bucky Fuller
  {'4084385' => 'SPEC-COLL'}, # Ginsberg
  {'8938812' => 'SPEC-COLL'}, # MALDEF
  {'3195844' => 'SAL3'} # nature
]

barcodes = [
  {'36105031007565' => 'SAL3'}, # Desert Tortoise, SAL3
  {'36105042640602' => 'SAL3'}, # Beethoven Symphony score, SAL3
  {'36105125611421' => 'SPEC-COLL'}, # New American Cookery, SPEC-COLL
  # huge records
  {'36105017963252' => 'SAL3'}, # Nature, SAL3
#  {'002ACX3485' => 'SPEC-COLL'}, # Nature, SPEC-COLL
  {'36105116029633' => 'SPEC-COLL'}, # Bucky Fuller, SPEC-COLL
  {'36105115968856' => 'SPEC-COLL'} # Ginsberg, SPEC-COLL
]

count = 10  # 10 is plenty;  the times aren't that variable

require 'vufind_times'
require 'requests_pl_times'
require 'symws_times'
ckeys.each { |ckey_entry|
  ckey = ckey_entry.keys.first
  library = ckey_entry[ckey]

  p "ckey: #{ckey}"

  vt = VufindTimes.new(ckey, count)
  vt.benchmark
  p "---------------------------------------"

  rpt = RequestsPlTimes.new(ckey, library, count)
  rpt.benchmark
  p "---------------------------------------"

  st = SymwsTimes.new(ckey, library, count)
  st.benchmark_no_library
  p "---------------------------------------"
  st.benchmark_w_json

  p '================================================'
  p '================================================'
}


require 'catalog_item_barcode'
barcodes.each { |barcode_entry|
  barcode = barcode_entry.keys.first
  library = barcode_entry[barcode]

  p "barcode: #{barcode}"

  st = SymwsTimes.new(barcode, library, count)
  st.benchmark_no_library
  p "---------------------------------------"
  st.benchmark_w_json
  p "---------------------------------------"

  cib = CatalogItemBarcode.new(barcode, count)
  cib.benchmark

  p '================================================'
  p '================================================'
}
