require 'yaml'

require 'ghtorrent/utils'

module GHTorrent
  module Settings

    include GHTorrent::Utils

    CONFIGKEYS = {
        :amqp_host => "amqp.host",
        :amqp_port => "amqp.port",
        :amqp_username => "amqp.username",
        :amqp_password => "amqp.password",
        :amqp_exchange => "amqp.exchange",
        :amqp_prefetch  => "amqp.prefetch",

        :sql_url => "sql.url",

        :mirror_urlbase => "mirror.urlbase",
        :mirror_urlbase_v2 => "mirror.urlbase_v2",
        :mirror_reqrate => "mirror.reqrate",
        :mirror_pollevery => "mirror.pollevery",
        :mirror_persister => "mirror.persister",
        :mirror_commit_pages_new_repo => "mirror.commit_pages_new_repo",

        :uniq_id => "mirror.uniq_id",

        :cache_mode      => "mirror.cache_mode",
        :cache_dir       => "mirror.cache_dir",
        :cache_stale_age => "mirror.cache_stale_age",

        :attach_ip => "mirror.attach_ip"
    }

    def config(key)
      read_value(settings, CONFIGKEYS[key])
    end

    def merge(more_keys)
      more_keys.each {|k,v| CONFIGKEYS[k] = v}
    end

    def merge_config_values(values)
      values.reduce(settings) {|acc, k|
        acc.merge_recursive write_value(settings, CONFIGKEYS[k[0]], k[1])
      }
    end

    def settings
      raise Exception("Unimplemented")
    end

  end
end