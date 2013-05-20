# -*- coding: utf-8 -*-
#
# Cookbook Name:: osx-apps
# Recipe:: default
#
# Copyright 2013, pekepeke
#
# All rights reserved - Do Not Redistribute
#

require 'fileutils'

include_recipe "homebrew"
include_recipe "dmg"
include_recipe "zip_app"

HomebrewPackages = [
  # "the_silver_searcher",
]
Applications = {
  'iTerm' => {
    source: 'http://iterm2.googlecode.com/files/iTerm2_v1_0_0.zip',
    provider: 'zip',
  },
  'Firefox' => {
    source: "http://download.mozilla.org/?product=firefox-20.0.1&os=osx&lang=ja-JP-mac",
    provider: 'zip',
  },
  'Google Chrome' => {
    source: 'https://dl.google.com/chrome/mac/stable/GoogleChrome.dmg',
    provider: 'dmg',
  },
  'Dropbox'=> {
    source: 'https://d1ilhw0800yew8.cloudfront.net/client/Dropbox%202.0.5.dmg',
    provider: 'dmg',
  },
  "Google Drive"=> {
    dmg_name: "googledrive", volumes_dir: 'Install Google Drive', source: "http://dl.google.com/drive/installgoogledrive.dmg",
    provider: 'dmg',
  },
  "Skype"=> {
    source: "http://www.skype.com/go/getskype-macosx.dmg",
    provider: 'dmg',
  },

  "KeyRemap4MacBook" => {
    source: "http://pqrs.org/macosx/keyremap4macbook/files/KeyRemap4MacBook-8.0.0.dmg",
    type: "pkg",
    provider: 'dmg',
  },
  "XtraFinder" => {
    source: "http://www.trankynam.com/xtrafinder/downloads/XtraFinder.dmg",
    type: "pkg",
  },
  "TakeMePop" => {
    source: 'http://hetima.com/takemepop/TakeMePop1.1.zip',
    provider: 'zip',
  },
  'BetterTouchTool' => {
    source: 'http://www.boastr.de/BetterTouchTool.zip',
    provider: 'zip',
  },
  'atMonitor' => {
    source: 'http://download.atpurpose.com/atMonitor/atMonitor.zip',
  },
  'Alfred 2' => {
    source: 'http://cachefly.alfredapp.com/Alfred_2.0.3_187.zip',
    provider: 'zip',
  },
  'GoogleJapaneseInput.localized/DictionaryTool'=> {
    source: 'https://dl.google.com/japanese-ime/latest/GoogleJapaneseInput.dmg',
    type: "pkg",
    provider: 'dmg',
  },
  "ClipMenu"=> {
    source: "https://dl.dropbox.com/u/1140644/clipmenu/ClipMenu_0.4.3.dmg",
    provider: 'dmg',
  },

  'AppCleaner'=> {
    source: 'http://www.freemacsoft.net/downloads/AppCleaner_2.1.zip',
    provider: 'zip',
  },
  'Zipeg'=> {
    source: 'http://www.zipeg.net/downloads/zipeg_mac.dmg',
    provider: 'dmg',
  },
  'Keka'=> {
    source: 'http://download.kekaosx.com/',
    provider: 'dmg',
  },
  'Caffeine' => {
    source: 'http://lightheadsw.com/files/releases/com.lightheadsw.Caffeine/Caffeine1.1.1.zip',
    provider: 'zip',
  },
  'Day-O'=> {
    source: 'http://shauninman.com/assets/downloads/Day-O.zip',
    provider: 'zip',
    # notifies: "ruby_block[setup-day-o]", # not run successfully
  },
  # 'HardCoreZipper'=> {
  #   source: 'http://www.geocities.jp/freeggggroup/nf/HardCoreZipper_213.zip',
  #   provider: 'zip',
  #   notifies: "ruby_block[setup-hardcorezipper]",
  # },
  "VLC"=> {
    source: "http://sourceforge.net/projects/vlc/files/2.0.5/macosx/vlc-2.0.5.dmg/download",
    volumes_dir: 'vlc-2.0.5',
    provider: 'dmg',
  },
  'CotEditor'=> {
    source: 'http://sourceforge.jp/projects/coteditor/downloads/54872/CotEditor_1.3.1.dmg',
    provider: 'dmg',
  },
  'MacVim'=> {
    source: 'http://macvim-kaoriya.googlecode.com/files/macvim-kaoriya-20121213.dmg',
    provider: 'dmg',
  },
  "Sublime Text 2"=> {
    dmg_name: "sublimetext2", source: "http://c758482.r82.cf2.rackcdn.com/Sublime%20Text%202.0.1.dmg",
    provider: 'dmg',
  },
  "nvALT"=> {
    source: "http://abyss.designheresy.com/nvalt/files/nvalt2.2b105.zip",
  },

  'DiffMerge'=> {
    source: 'http://download-us.sourcegear.com/DiffMerge/3.3.2/DiffMerge.3.3.2.1139.dmg',
    provider: 'dmg',
  },
  'stroy'=> {
    source: 'http://stroy.wikidot.com/local--files/download/stroy-app-intel-1.0.3.zip',
    provider: 'zip',
  },
  "Virtualbox"=> {
    source: "http://download.virtualbox.org/virtualbox/4.2.12/VirtualBox-4.2.12-84980-OSX.dmg",
    type: "mpkg",
    provider: 'dmg',
  },
  "Cyberduck"=> {
    source: "http://cyberduck.ch/Cyberduck-4.3.1.zip",
  },
  "Charles"=> {
    source: 'www.charlesproxy.com/assets/release/3.7/charles-proxy-3.7.dmg',
    provider: 'dmg',
  },
  "Sequel Pro"=> {
    source: "https://sequel-pro.googlecode.com/files/sequel-pro-1.0.2.dmg",
    provider: 'dmg',
  },
  "Simulator Folders" =>{
    source: 'http://www.gettracktime.com/dbrd/download.php?id=8',
    provider: 'zip',
  },
  # "Qmind" => {
  #   source: 'https://bitbucket.org/qvacua/qvacua/downloads/Qmind-0.3.1.zip'
  # },
  # "Silverlight"=> {
  #   source: "http://silverlight.dlservice.microsoft.com/download/D/C/2/DC2D5838-9138-4D25-AA92-52F61F7C51E6/runtime/Silverlight.dmg",
  #   type: "pkg",
  #   checksum: "6d4a0ad4552d9815531463eb3f467fb8cf4bffcc",
  #   package_id: "com.microsoft.installSilverlightPlugin",
  # },
  # "pgAdmin3"=> {
  #   source: "http://wwwmaster.postgresql.org/redir/198/h/pgadmin3/release/v1.12.3/osx/pgadmin3-1.12.3.dmg",
  #   checksum: "9435f79d5b52d0febeddfad392adf82db9df159196f496c1ab139a6957242ce9",
  #   accept_eula: true,
  # },
  # "Vagrant"=> {
  #   source: "http://files.vagrantup.com/packages/87613ec9392d4660ffcb1d5755307136c06af08c/Vagrant.dmg", type: "pkg",
  #   provider: 'dmg',
  # },
}.map{ |name, opt| OpenStruct.new(opt.merge(app_name: name)) }


HomebrewPackages.each do |name|
  package name do
    provider Chef::Provider::Package::Homebrew
  end
end

Applications.each do |app|
  if app.provider == "zip" || app.source =~ %r[\.zip$]
    zip_app_package app.app_name do
      %w[
        app source checksum destination zip_file
      ].each do |attr|
        send(attr, app.send(attr)) if app.respond_to? attr
      end
      notifies :create, app.notifies, :immediately if app.notifies
    end
  elsif app.provider == "dmg" || app.source =~ %r[\.dmg$]
    dmg_package app.app_name do
      %w[
        source owner checksum destination type
        volumes_dir package_id dmg_name dmg_passphrase accept_eula
      ].each do |attr|
        send(attr, app.send(attr)) if app.respond_to? attr
      end
      notifies :create, app.notifies, :immediately if app.notifies
    end
  end
end

ruby_block "setup-day-o" do
  dir_path = "/Applications/Day-O"
  block do
    FileUtils.mv "#{dir_path}/Day-O.app", "/Applications/Day-O.app"
    FileUtils.rm_r dir_path
  end
  only_if { File.exist? dir_path }
  action :create
end

ruby_block "setup-hardcorezipper" do
  dir_path = "/Applications/HardCoreZipper_213 ƒ"
  block do
    FileUtils.mv "#{dir_path}/HardCoreZipper.app", "/Application/HardCoreZipper.app"
    FileUtils.rm_r "#{dir_path}"
  end
  only_if { File.exist? dir_path }
  action :nothing
end
