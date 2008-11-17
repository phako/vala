using GLib;

class Maman.Bar : Object {
	public void do_action () {
		stdout.printf (" 3");
	}
}

class Maman.SubBar : Bar {
	public void do_action () {
		stdout.printf (" BAD");
	}

	public void run () {
		stdout.printf (" 2");

		base.do_action ();

		stdout.printf (" 4");
	}

	static int main (string[] args) {
		stdout.printf ("Hidden Base Method Access Test: 1");

		var bar = new SubBar ();
		bar.run ();
	
		stdout.printf (" 5\n");

		return 0;
	}
}