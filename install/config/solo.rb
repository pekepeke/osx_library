root_path = File.expand_path(File.join(File.dirname(__FILE__), '..'))

cookbook_path             [ File.join(root_path, "cookbooks"),
                            File.join(root_path, "site-cookbooks") ]

json_attribs              File.expand_path("../node.json", __FILE__)
role_path                 File.join(root_path, "roles")
# data_bag_path             File.join(root_path, "data_bags")
# encrypted_data_bag_secret File.join(root_path, "data_bag_key")

cache_root_path = File.expand_path("~/.chef/osx-apps")

file_cache_path           File.join(cache_root_path, "cache")
cache_options[:path]    = File.join(cache_root_path, "cache")

