require 'json'

isLocalIntegrationMode = ENV['is_local_integration_mode'].nil?? false : ENV['is_local_integration_mode']

Pod::Spec.new do |spec|
  spec.name         = 'LKMessageExternalIMP'
  spec.version      = "0.0.1"
  spec.summary      = "pod for local build."
  spec.homepage     = "https://github.com/larksuite/alchemy_app_demo"
  spec.license      = "MIT"
  spec.author       = { "" => "" }
  spec.source       = { :git => "", :tag => "" }
  spec.vendored_frameworks = "Framework/*.framework"
  spec.ios.deployment_target = '12.0'
  spec.swift_version = '5.0'
  
  spec.dependency 'LKNativeAppPublicKitIMP'
  
  puts "AlchemyEngine: ModulePod: Check isLocalIntegrationMode #{spec.name}: #{isLocalIntegrationMode.to_s}"

  if isLocalIntegrationMode
    spec.source_files = 'src/**/*.{h,m,mm,swift}'
    file = File.read('../alchemy/integration_config_v2.json')
    data_hash = JSON.parse(file)
    added_dependencies = {}
    current_module = data_hash.find { |item| item['publishName'] == spec.name }
    if current_module
      associated_components = current_module['dependencies']
      # 遍历 associated_components
      associated_components.each do |item|
        key = item["name"]
        if !added_dependencies.key?(key)
          # 只有当依赖项还未添加时，才添加依赖项
          version = item['version']
          # 将 key 和 localVersion 添加到 podspec 的 dependency 列表
          spec.dependency key, version
          
          puts "AlchemyEngine: ModulePod: #{spec.name} dependency #{key}:#{version}"
          
          # 记录已添加的依赖项
          added_dependencies[key] = true
        end
      end
    end
  end  
end
