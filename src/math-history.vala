/*
 * Copyright (C) 2014 ELITA ASTRID ANGELINA LOBO
 *
 * This program is free software: you can redistribute it and/or modify it under
 * the terms of the GNU General Public License as published by the Free Software
 * Foundation, either version 3 of the License, or (at your option) any later
 * version. See http://www.gnu.org/copyleft/gpl.html the full text of the
 * license.
*/

[GtkTemplate (ui = "/org/x/valuate/history-view.ui")]
public class HistoryView : Gtk.ScrolledWindow
{
    string? last_equation = null;

    [GtkChild]
    unowned Gtk.ListBox listbox;

    private Settings settings;

    construct {
        settings = new Settings ("org.x.valuate");
        settings.changed["keep-history"].connect (() => {
            if (!settings.get_boolean ("keep-history")) {
                var history_path = Path.build_filename (Environment.get_user_data_dir (), "valuate", "history");
                if (FileUtils.test (history_path, FileTest.EXISTS)) {
                    FileUtils.remove (history_path);
                }
            }
        });
    }

    private int _rows = 0;
    private Serializer serializer;
    private int _current = 0;
    public int rows {get {return _rows;} }
    public int current {get {return _current;} set {_current = value.clamp(0, _rows); } }
    public signal void answer_clicked   (string ans);
    public signal void equation_clicked (string equation);
    public signal void row_added	();


    public HistoryEntry? get_entry_at(int index)
    {
        if ( index >= 0 && index < rows)
            return (HistoryEntry?) listbox.get_row_at_index (index);
        return null;
    }

    [GtkCallback]
    public void scroll_bottom ()
    {
        var adjustment = listbox.get_adjustment ();
        // TODO make this dynamic, do not hardcode listbox_height_request/number_of_rows
        int width, height;
        get_size_request (out width, out height);
        adjustment.page_size = height / 3;
        adjustment.set_value (adjustment.get_upper () - adjustment.get_page_size ());
    }

    private Serializer save_serializer;

    private Serializer get_save_serializer ()
    {
        if (save_serializer == null) {
            save_serializer = new Serializer (DisplayFormat.AUTOMATIC, 10, 9);
            save_serializer.set_show_thousands_separators (false);
        }
        return save_serializer;
    }

    private bool history_loaded = false;

    public void load_history ()
    {
        if (history_loaded)
            return;
        history_loaded = true;

        if (!settings.get_boolean ("keep-history"))
            return;

        var history_path = Path.build_filename (Environment.get_user_data_dir (), "valuate", "history");
        if (!FileUtils.test (history_path, FileTest.EXISTS))
            return;

        try
        {
            string content;
            FileUtils.get_contents (history_path, out content);
            var lines = content.split ("\n");
            
            var s = get_save_serializer ();

            for (int i = 0; i < lines.length - 1; i += 2)
            {
                var eq = lines[i].strip ();
                if (eq == "")
                    continue;
                var ans_str = lines[i+1].strip ();
                
                var number = s.from_string (ans_str);
                if (number != null)
                {
                    insert_entry_without_saving (eq, number);
                }
            }
        }
        catch (Error e)
        {
            warning ("Failed to load history: %s", e.message);
        }
    }

    private void insert_entry_without_saving (string equation, Number answer)
    {
        var entry = new HistoryEntry (equation, answer, serializer);

        listbox.insert (entry, -1);
        entry.show ();

        entry.answer_clicked.connect ((ans) => { this.answer_clicked (ans); });
        entry.equation_clicked.connect ((eq) => { this.equation_clicked (eq); });

        last_equation = equation;
        _rows++;
        current = rows - 1;
        row_added ();
    }

    private void save_entry (string equation, Number answer)
    {
        if (!settings.get_boolean ("keep-history"))
            return;

        var history_path = Path.build_filename (Environment.get_user_data_dir (), "valuate", "history");
        var dir = Path.get_dirname (history_path);
        DirUtils.create_with_parents (dir, 0700);

        var s = get_save_serializer ();
        var ans_str = s.to_string (answer);

        var file = FileStream.open (history_path, "a");
        if (file != null)
        {
            file.printf ("%s\n%s\n", equation, ans_str);
        }
    }

    public void insert_entry (string equation, Number answer, int number_base, uint representation_base)
    {
        if (last_equation == equation)
            return;

        insert_entry_without_saving (equation, answer);
        save_entry (equation, answer);
    }

    public void clear ()
    {
        _rows = 0;
        _current = 0;
        listbox.foreach ((child) => { listbox.remove(child); });

        var history_path = Path.build_filename (Environment.get_user_data_dir (), "valuate", "history");
        if (FileUtils.test (history_path, FileTest.EXISTS))
        {
            FileUtils.remove (history_path);
        }
    }

    public void set_serializer (Serializer serializer)
    {
        this.serializer = serializer;
        load_history ();
        listbox.foreach ((child) => { ((HistoryEntry)child).redisplay (serializer); });
    }
}

[GtkTemplate (ui = "/org/x/valuate/history-entry.ui")]
public class HistoryEntry : Gtk.ListBoxRow
{
    [GtkChild]
    unowned Gtk.Label equation_label;
    [GtkChild]
    public unowned Gtk.Label answer_label;

    private Number number;

    public signal void answer_clicked (string ans);
    public signal void equation_clicked (string equation);

    public HistoryEntry (string equation,
                         Number answer,
                         Serializer serializer)
    {
        this.number = answer;
        equation_label.set_text (equation);
        equation_label.set_tooltip_text (equation);
        redisplay (serializer);
    }

    public void redisplay (Serializer serializer)
    {
        var answer = serializer.to_string (number);
        answer_label.set_tooltip_text (answer);
        answer_label.set_text (answer);
    }

    [GtkCallback]
    public bool answer_clicked_cb (Gtk.Widget widget, Gdk.EventButton eventbutton)
    {
        var answer = answer_label.get_text ();
        if (answer != null)
            answer_clicked (answer);
        return true;
    }

    [GtkCallback]
    private bool equation_clicked_cb (Gtk.Widget widget, Gdk.EventButton eventbutton)
    {
        var equation = equation_label.get_text ();
        if (equation != null)
            equation_clicked (equation);
        return true;
    }
}


