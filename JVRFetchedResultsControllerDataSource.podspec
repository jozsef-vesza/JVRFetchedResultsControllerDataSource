Pod::Spec.new do |s|
  s.name         = "JVRFetchedResultsControllerDataSource"
  s.version      = "1.0.0"
  s.summary      = "A reusable class that combines UITableViewDataSource and NSFetchedResultsControllerDelegate."
  s.homepage     = "https://github.com/jozsef-vesza/JVRFetchedResultsControllerDataSource"
  s.license      = "MIT"
  s.author             = { "József Vesza" => "jozsef.vsza@outlook.com" }
  s.social_media_url   = "http://twitter.com/j_vesza"
  s.platform     = :ios, "5.0"
  s.source       = { :git => "https://github.com/jozsef-vesza/JVRFetchedResultsControllerDataSource.git", :tag => s.version }
  s.source_files  = "*.{h,m}"
  s.exclude_files = "Lighter Core Data/*"
  s.public_header_files = "*.h"
  s.framework  = "CoreData"
  s.requires_arc = true
  s.dependency 'JVRCellConfiguratorDelegate'
end
