/* twitter-glib-1.0.vapi generated by vapigen, do not modify. */

[CCode (cprefix = "Twitter", lower_case_cprefix = "twitter_")]
namespace Twitter {
	[CCode (cheader_filename = "twitter-glib/twitter-glib.h")]
	public class Client : GLib.Object {
		[CCode (has_construct_function = false)]
		public Client ();
		public ulong add_favorite (uint status_id);
		public ulong add_friend (string user);
		public ulong add_status (string text);
		public void end_session ();
		public ulong follow_user (string user);
		[CCode (has_construct_function = false)]
		public Client.for_user (string email, string password);
		[CCode (has_construct_function = false)]
		public Client.full (Twitter.Provider provider, string? base_url, string? email, string? password);
		public ulong get_archive (int page);
		public unowned string get_base_url ();
		public ulong get_favorites (string user, int page);
		public ulong get_followers (int page, bool omit_status);
		public ulong get_friends (string user, int page, bool omit_status);
		public ulong get_friends_timeline (string friend_, int64 since_date);
		public Twitter.Provider get_provider ();
		public ulong get_public_timeline (uint since_id);
		public void get_rate_limit (int limit, int remaining);
		public ulong get_replies ();
		public ulong get_status (uint status_id);
		public void get_user (out unowned string email, out unowned string password);
		public ulong get_user_timeline (string user, uint count, int64 since_date);
		public ulong leave_user (string user);
		public ulong remove_favorite (uint status_id);
		public ulong remove_friend (string user);
		public ulong remove_status (uint status_id);
		public void set_user (string email, string password);
		public ulong show_user_from_email (string email);
		public ulong show_user_from_id (string id_or_screen_name);
		public ulong verify_user ();
		public string base_url { get; construct; }
		[NoAccessorMethod]
		public string email { owned get; set; }
		[NoAccessorMethod]
		public int max_requests { get; }
		[NoAccessorMethod]
		public string password { owned get; set; }
		public Twitter.Provider provider { get; construct; }
		[NoAccessorMethod]
		public int remaining_requests { get; }
		[NoAccessorMethod]
		public string user_agent { owned get; construct; }
		public virtual signal bool authenticate (Twitter.AuthState state);
		public virtual signal void session_ended ();
		public virtual signal void status_received (ulong handle, Twitter.Status status, void* error);
		public virtual signal void timeline_complete ();
		public virtual signal void user_received (ulong handle, Twitter.User user, void* error);
		public virtual signal void user_verified (ulong handle, bool is_verified, void* error);
	}
	[CCode (cheader_filename = "twitter-glib/twitter-glib.h")]
	public class Status : GLib.InitiallyUnowned {
		[CCode (has_construct_function = false)]
		public Status ();
		[CCode (has_construct_function = false)]
		public Status.from_data (string buffer);
		public unowned string get_created_at ();
		public uint get_id ();
		public uint get_reply_to_status ();
		public uint get_reply_to_user ();
		public unowned string get_source ();
		public unowned string get_text ();
		public bool get_truncated ();
		public unowned string get_url ();
		public unowned Twitter.User get_user ();
		public bool load_from_data (string buffer) throws GLib.Error;
		public string created_at { get; }
		public uint id { get; }
		public uint reply_to_status { get; }
		public uint reply_to_user { get; }
		public string source { get; }
		public string text { get; }
		public bool truncated { get; }
		public string url { get; }
		public Twitter.User user { get; }
		public virtual signal void changed ();
	}
	[CCode (cheader_filename = "twitter-glib/twitter-glib.h")]
	public class Timeline : GLib.Object {
		[CCode (has_construct_function = false)]
		public Timeline ();
		[CCode (has_construct_function = false)]
		public Timeline.from_data (string buffer);
		public unowned GLib.List get_all ();
		public uint get_count ();
		public Twitter.Status get_id (uint id);
		public Twitter.Status get_pos (int index_);
		public bool load_from_data (string buffer) throws GLib.Error;
	}
	[CCode (cheader_filename = "twitter-glib/twitter-glib.h")]
	public class User : GLib.InitiallyUnowned {
		[CCode (has_construct_function = false)]
		public User ();
		[CCode (has_construct_function = false)]
		public User.from_data (string buffer);
		public unowned string get_created_at ();
		public unowned string get_description ();
		public uint get_favorites_count ();
		public uint get_followers_count ();
		public bool get_following ();
		public uint get_friends_count ();
		public uint get_id ();
		public unowned string get_location ();
		public unowned string get_name ();
		public Gdk.Pixbuf get_profile_image ();
		public unowned string get_profile_image_url ();
		public bool get_protected ();
		public unowned string get_screen_name ();
		public Twitter.Status get_status ();
		public uint get_statuses_count ();
		public unowned string get_time_zone ();
		public unowned string get_url ();
		public int get_utc_offset ();
		public bool load_from_data (string buffer) throws GLib.Error;
		public string created_at { get; }
		public string description { get; }
		public uint favorites_count { get; }
		public uint followers_count { get; }
		public bool following { get; }
		public uint friends_count { get; }
		public uint id { get; }
		public string location { get; }
		public string name { get; }
		public string profile_image_url { get; }
		public bool @protected { get; }
		public string screen_name { get; }
		public Twitter.Status status { get; }
		public uint statuses_count { get; }
		public string time_zone { get; }
		public string url { get; }
		public int utc_offset { get; }
		public virtual signal void changed ();
	}
	[CCode (cheader_filename = "twitter-glib/twitter-glib.h")]
	public class UserList : GLib.Object {
		[CCode (has_construct_function = false)]
		public UserList ();
		[CCode (has_construct_function = false)]
		public UserList.from_data (string buffer);
		public unowned GLib.List get_all ();
		public uint get_count ();
		public Twitter.User get_id (uint id);
		public Twitter.User get_pos (int index_);
		public bool load_from_data (string buffer) throws GLib.Error;
	}
	[CCode (cprefix = "TWITTER_AUTH_", cheader_filename = "twitter-glib/twitter-glib.h")]
	public enum AuthState {
		NEGOTIATING,
		RETRY,
		FAILED,
		SUCCESS
	}
	[CCode (cprefix = "TWITTER_ERROR_", cheader_filename = "twitter-glib/twitter-glib.h")]
	public enum Error {
		HOST_NOT_FOUND,
		CANCELLED,
		PERMISSION_DENIED,
		NOT_FOUND,
		TIMED_OUT,
		FAILED,
		NOT_MODIFIED,
		PARSE_ERROR
	}
	[CCode (cprefix = "TWITTER_", cheader_filename = "twitter-glib/twitter-glib.h")]
	public enum Provider {
		CUSTOM_PROVIDER,
		DEFAULT_PROVIDER,
		IDENTI_CA
	}
	[CCode (cheader_filename = "twitter-glib/twitter-glib.h")]
	public const string GLIB_API_VERSION_S;
	[CCode (cheader_filename = "twitter-glib/twitter-glib.h")]
	public const int GLIB_MAJOR_VERSION;
	[CCode (cheader_filename = "twitter-glib/twitter-glib.h")]
	public const int GLIB_MICRO_VERSION;
	[CCode (cheader_filename = "twitter-glib/twitter-glib.h")]
	public const int GLIB_MINOR_VERSION;
	[CCode (cheader_filename = "twitter-glib/twitter-glib.h")]
	public const int GLIB_VERSION_HEX;
	[CCode (cheader_filename = "twitter-glib/twitter-glib.h")]
	public const string GLIB_VERSION_S;
	[CCode (cheader_filename = "twitter-glib/twitter-glib.h")]
	public static bool date_to_time_val (string date, out GLib.TimeVal time_);
	[CCode (cheader_filename = "twitter-glib/twitter-glib.h")]
	public static Twitter.Error error_from_status (uint status);
	[CCode (cheader_filename = "twitter-glib/twitter-glib.h")]
	public static GLib.Quark error_quark ();
	[CCode (cheader_filename = "twitter-glib/twitter-glib.h")]
	public static unowned string http_date_from_delta (int seconds);
	[CCode (cheader_filename = "twitter-glib/twitter-glib.h")]
	public static unowned string http_date_from_time_t (ulong time_);
	[CCode (cheader_filename = "twitter-glib/twitter-glib.h")]
	public static int http_date_to_delta (string date);
	[CCode (cheader_filename = "twitter-glib/twitter-glib.h")]
	public static ulong http_date_to_time_t (string date);
}
