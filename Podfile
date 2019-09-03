platform :ios, '12.0'

def networking
	pod 'Moya/RxSwift'
	pod 'RxCocoa'
	pod 'Kingfisher'
end

target 'CLEANMovies' do
  use_frameworks!
  inhibit_all_warnings!

  # Pods for CLEANMovies
  networking

  target 'CLEANMoviesTests' do
    inherit! :search_paths
    # Pods for testing
  end

end
