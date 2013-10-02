/************************************************************************
  TicTacToeWindow.vala
  Copyright (C) 2011 Nick Glynn
 
  This header is free software; you can redistribute it and/or modify it
  under the terms of the GNU Lesser General Public License as published
  by the Free Software Foundation; either version 2.1 of the License,
  or (at your option) any later version.
 
  This header is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
  Lesser General Public License for more details.
 
  You should have received a copy of the GNU Lesser General Public
  License along with this library; if not, write to the Free Software
  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301
  USA.
 ********************************************************************/

/// \file   TicTacToeWindow
/// \brief  Main file and window class for TicTacToe application

using Gtk;

public class TicTacToeWindow : Gtk.Window {

    TicTacToeWindow () {
        set_title ("Tic-Tac-Toe");
        
        // File menu
        var menuBar = new Gtk.MenuBar();
        var file_launcher = new Gtk.MenuItem.with_mnemonic ("_File");
        var fileMenu = new Gtk.Menu();
        file_launcher.set_submenu(fileMenu);
        menuBar.add(file_launcher);
        var quit = new Gtk.MenuItem.with_label ("Quit");
        quit.activate.connect (Gtk.main_quit);
        fileMenu.add(quit);
        
        // Layout
        var layoutGrid = new Grid ();
        var tttBoard = new TicTacToeBoard ();
        layoutGrid.attach (menuBar, 0, 0, 1, 1);
        layoutGrid.attach (tttBoard, 0, 1, 1, 1);
        add (layoutGrid);
        
        tttBoard.game_over.connect((s) => {
            // Display an error dialog
            var dialog = new MessageDialog(this, DialogFlags.MODAL, MessageType.INFO, ButtonsType.CLOSE, s);
            dialog.set_title("Winner!");
            dialog.response.connect((id) => dialog.destroy());
            // Break here while the dialog runs!
            dialog.run();
            tttBoard.resetGrid();
        });
        
        // Wire it and show it
        destroy.connect (Gtk.main_quit);
        show_all ();
    }
    
    static int main (string[] args) {
        Gtk.init (ref args);
        new TicTacToeWindow ();
        Gtk.main ();
        return 0;
    }
}

