/* HistoryView.c generated by valac 0.32.1, the Vala compiler
 * generated from HistoryView.vala, do not modify */

/*
 * This file is part of haste-applet
 *
 * Copyright (C) 2016 Stefan Ric <stfric369@gmail.com>
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 */

#include <glib.h>
#include <glib-object.h>
#include <gtk/gtk.h>
#include <gio/gio.h>
#include <stdlib.h>
#include <string.h>


#define HASTE_APPLET_TYPE_HISTORY_VIEW (haste_applet_history_view_get_type ())
#define HASTE_APPLET_HISTORY_VIEW(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), HASTE_APPLET_TYPE_HISTORY_VIEW, HasteAppletHistoryView))
#define HASTE_APPLET_HISTORY_VIEW_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), HASTE_APPLET_TYPE_HISTORY_VIEW, HasteAppletHistoryViewClass))
#define HASTE_APPLET_IS_HISTORY_VIEW(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), HASTE_APPLET_TYPE_HISTORY_VIEW))
#define HASTE_APPLET_IS_HISTORY_VIEW_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), HASTE_APPLET_TYPE_HISTORY_VIEW))
#define HASTE_APPLET_HISTORY_VIEW_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), HASTE_APPLET_TYPE_HISTORY_VIEW, HasteAppletHistoryViewClass))

typedef struct _HasteAppletHistoryView HasteAppletHistoryView;
typedef struct _HasteAppletHistoryViewClass HasteAppletHistoryViewClass;
typedef struct _HasteAppletHistoryViewPrivate HasteAppletHistoryViewPrivate;

#define HASTE_APPLET_TYPE_HISTORY_VIEW_ITEM (haste_applet_history_view_item_get_type ())
#define HASTE_APPLET_HISTORY_VIEW_ITEM(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), HASTE_APPLET_TYPE_HISTORY_VIEW_ITEM, HasteAppletHistoryViewItem))
#define HASTE_APPLET_HISTORY_VIEW_ITEM_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), HASTE_APPLET_TYPE_HISTORY_VIEW_ITEM, HasteAppletHistoryViewItemClass))
#define HASTE_APPLET_IS_HISTORY_VIEW_ITEM(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), HASTE_APPLET_TYPE_HISTORY_VIEW_ITEM))
#define HASTE_APPLET_IS_HISTORY_VIEW_ITEM_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), HASTE_APPLET_TYPE_HISTORY_VIEW_ITEM))
#define HASTE_APPLET_HISTORY_VIEW_ITEM_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), HASTE_APPLET_TYPE_HISTORY_VIEW_ITEM, HasteAppletHistoryViewItemClass))

typedef struct _HasteAppletHistoryViewItem HasteAppletHistoryViewItem;
typedef struct _HasteAppletHistoryViewItemClass HasteAppletHistoryViewItemClass;
#define _g_object_unref0(var) ((var == NULL) ? NULL : (var = (g_object_unref (var), NULL)))

#define HASTE_APPLET_TYPE_AUTOMATIC_SCROLL_BOX (haste_applet_automatic_scroll_box_get_type ())
#define HASTE_APPLET_AUTOMATIC_SCROLL_BOX(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), HASTE_APPLET_TYPE_AUTOMATIC_SCROLL_BOX, HasteAppletAutomaticScrollBox))
#define HASTE_APPLET_AUTOMATIC_SCROLL_BOX_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), HASTE_APPLET_TYPE_AUTOMATIC_SCROLL_BOX, HasteAppletAutomaticScrollBoxClass))
#define HASTE_APPLET_IS_AUTOMATIC_SCROLL_BOX(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), HASTE_APPLET_TYPE_AUTOMATIC_SCROLL_BOX))
#define HASTE_APPLET_IS_AUTOMATIC_SCROLL_BOX_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), HASTE_APPLET_TYPE_AUTOMATIC_SCROLL_BOX))
#define HASTE_APPLET_AUTOMATIC_SCROLL_BOX_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), HASTE_APPLET_TYPE_AUTOMATIC_SCROLL_BOX, HasteAppletAutomaticScrollBoxClass))

typedef struct _HasteAppletAutomaticScrollBox HasteAppletAutomaticScrollBox;
typedef struct _HasteAppletAutomaticScrollBoxClass HasteAppletAutomaticScrollBoxClass;
#define _g_list_free0(var) ((var == NULL) ? NULL : (var = (g_list_free (var), NULL)))
typedef struct _Block4Data Block4Data;
typedef struct _HasteAppletHistoryViewUpdateHistoryData HasteAppletHistoryViewUpdateHistoryData;
#define _g_variant_unref0(var) ((var == NULL) ? NULL : (var = (g_variant_unref (var), NULL)))
#define _g_date_time_unref0(var) ((var == NULL) ? NULL : (var = (g_date_time_unref (var), NULL)))

struct _HasteAppletHistoryView {
	GtkBox parent_instance;
	HasteAppletHistoryViewPrivate * priv;
	GtkButton* history_add_button;
};

struct _HasteAppletHistoryViewClass {
	GtkBoxClass parent_class;
};

struct _HasteAppletHistoryViewPrivate {
	GtkButton* clear_all_button;
	GtkListBox* history_listbox;
	GtkClipboard* clipboard;
	GSettings* settings;
	HasteAppletHistoryViewItem* history_view_item;
};

struct _Block4Data {
	int _ref_count_;
	HasteAppletHistoryView* self;
	GtkListBoxRow* parent;
	gpointer _async_data_;
};

struct _HasteAppletHistoryViewUpdateHistoryData {
	int _state_;
	GObject* _source_object_;
	GAsyncResult* _res_;
	GSimpleAsyncResult* _async_result;
	HasteAppletHistoryView* self;
	gint n;
	gboolean startup;
	Block4Data* _data4_;
	GtkListBoxRow* separator_item;
	GtkListBox* _tmp0_;
	GList* _tmp1_;
	GList* _tmp2_;
	guint _tmp3_;
	gboolean _tmp4_;
	GtkSeparator* separator;
	GtkSeparator* _tmp5_;
	GtkListBoxRow* _tmp6_;
	GtkSeparator* _tmp7_;
	GtkListBoxRow* _tmp8_;
	GtkListBoxRow* _tmp9_;
	GtkListBoxRow* _tmp10_;
	GtkListBoxRow* _tmp11_;
	GtkSeparator* _tmp12_;
	GtkListBox* _tmp13_;
	GtkListBoxRow* _tmp14_;
	gint _tmp15_;
	GSettings* _tmp16_;
	HasteAppletHistoryViewItem* _tmp17_;
	GtkListBox* _tmp18_;
	HasteAppletHistoryViewItem* _tmp19_;
	HasteAppletHistoryViewItem* _tmp20_;
	GtkContainer* _tmp21_;
	GtkListBoxRow* _tmp22_;
	GtkListBoxRow* _tmp23_;
	GtkListBoxRow* _tmp24_;
	GtkListBoxRow* _tmp25_;
	GtkListBox* _tmp26_;
	gboolean _tmp27_;
	HasteAppletHistoryViewItem* _tmp28_;
	HasteAppletHistoryViewItem* _tmp29_;
	HasteAppletHistoryViewItem* _tmp30_;
	HasteAppletHistoryViewItem* _tmp31_;
};


static gpointer haste_applet_history_view_parent_class = NULL;
static GType haste_applet_history_view_type_id = 0;

GType haste_applet_history_view_get_type (void) G_GNUC_CONST;
GType haste_applet_history_view_register_type (GTypeModule * module);
GType haste_applet_history_view_item_get_type (void) G_GNUC_CONST;
GType haste_applet_history_view_item_register_type (GTypeModule * module);
#define HASTE_APPLET_HISTORY_VIEW_GET_PRIVATE(o) (G_TYPE_INSTANCE_GET_PRIVATE ((o), HASTE_APPLET_TYPE_HISTORY_VIEW, HasteAppletHistoryViewPrivate))
enum  {
	HASTE_APPLET_HISTORY_VIEW_DUMMY_PROPERTY
};
HasteAppletHistoryView* haste_applet_history_view_new (GSettings* settings, GtkClipboard* clipboard);
HasteAppletHistoryView* haste_applet_history_view_construct (GType object_type, GSettings* settings, GtkClipboard* clipboard);
GType haste_applet_automatic_scroll_box_get_type (void) G_GNUC_CONST;
GType haste_applet_automatic_scroll_box_register_type (GTypeModule * module);
HasteAppletAutomaticScrollBox* haste_applet_automatic_scroll_box_new (GtkAdjustment* hadj, GtkAdjustment* vadj);
HasteAppletAutomaticScrollBox* haste_applet_automatic_scroll_box_construct (GType object_type, GtkAdjustment* hadj, GtkAdjustment* vadj);
void haste_applet_automatic_scroll_box_set_max_height (HasteAppletAutomaticScrollBox* self, gint value);
void haste_applet_history_view_clear_all (HasteAppletHistoryView* self);
static void _haste_applet_history_view_clear_all_gtk_button_clicked (GtkButton* _sender, gpointer self);
void haste_applet_history_view_update_child_count (HasteAppletHistoryView* self);
static void haste_applet_history_view_update_history_data_free (gpointer _data);
void haste_applet_history_view_update_history (HasteAppletHistoryView* self, gint n, gboolean startup, GAsyncReadyCallback _callback_, gpointer _user_data_);
void haste_applet_history_view_update_history_finish (HasteAppletHistoryView* self, GAsyncResult* _res_);
static gboolean haste_applet_history_view_update_history_co (HasteAppletHistoryViewUpdateHistoryData* _data_);
static Block4Data* block4_data_ref (Block4Data* _data4_);
static void block4_data_unref (void * _userdata_);
HasteAppletHistoryViewItem* haste_applet_history_view_item_new (gint n, GSettings* settings);
HasteAppletHistoryViewItem* haste_applet_history_view_item_construct (GType object_type, gint n, GSettings* settings);
static gboolean ___lambda15_ (HasteAppletHistoryView* self);
static gboolean ____lambda15__gsource_func (gpointer self);
static void __lambda16_ (HasteAppletHistoryView* self, const gchar* url);
static void ___lambda16__haste_applet_history_view_item_copy (HasteAppletHistoryViewItem* _sender, const gchar* url, gpointer self);
static void __lambda17_ (Block4Data* _data4_);
static void ___lambda17__haste_applet_history_view_item_deletion (HasteAppletHistoryViewItem* _sender, gpointer self);
void haste_applet_history_view_add_to_history (HasteAppletHistoryView* self, const gchar* link, const gchar* title);
static void _vala_array_add1 (GVariant*** array, int* length, int* size, GVariant* value);
static void _vala_array_add2 (GVariant*** array, int* length, int* size, GVariant* value);
static void haste_applet_history_view_finalize (GObject* obj);
static void _vala_array_destroy (gpointer array, gint array_length, GDestroyNotify destroy_func);
static void _vala_array_free (gpointer array, gint array_length, GDestroyNotify destroy_func);


static gpointer _g_object_ref0 (gpointer self) {
	return self ? g_object_ref (self) : NULL;
}


static void _haste_applet_history_view_clear_all_gtk_button_clicked (GtkButton* _sender, gpointer self) {
	haste_applet_history_view_clear_all ((HasteAppletHistoryView*) self);
}


HasteAppletHistoryView* haste_applet_history_view_construct (GType object_type, GSettings* settings, GtkClipboard* clipboard) {
	HasteAppletHistoryView * self = NULL;
	GSettings* _tmp0_ = NULL;
	GSettings* _tmp1_ = NULL;
	GtkClipboard* _tmp2_ = NULL;
	GtkClipboard* _tmp3_ = NULL;
	GtkLabel* header_label = NULL;
	GtkLabel* _tmp4_ = NULL;
	GtkStyleContext* _tmp5_ = NULL;
	GtkButton* _tmp6_ = NULL;
	GtkButton* _tmp7_ = NULL;
	GtkButton* _tmp8_ = NULL;
	GtkBox* header_sub_box = NULL;
	GtkBox* _tmp9_ = NULL;
	GtkButton* _tmp10_ = NULL;
	GtkBox* header_box = NULL;
	GtkBox* _tmp11_ = NULL;
	GtkSeparator* _tmp12_ = NULL;
	GtkSeparator* _tmp13_ = NULL;
	GtkListBox* _tmp14_ = NULL;
	GtkListBox* _tmp15_ = NULL;
	HasteAppletAutomaticScrollBox* history_scroller = NULL;
	HasteAppletAutomaticScrollBox* _tmp16_ = NULL;
	GtkListBox* _tmp17_ = NULL;
	GtkButton* _tmp18_ = NULL;
	GtkButton* _tmp19_ = NULL;
	GtkWidget* _tmp20_ = NULL;
	GtkButton* _tmp21_ = NULL;
	GtkWidget* _tmp22_ = NULL;
	GtkButton* _tmp23_ = NULL;
	GtkButton* _tmp24_ = NULL;
	GtkButton* _tmp25_ = NULL;
	GtkButton* _tmp26_ = NULL;
	GtkStyleContext* _tmp27_ = NULL;
	GtkBox* clear_all_box = NULL;
	GtkBox* _tmp28_ = NULL;
	GtkSeparator* _tmp29_ = NULL;
	GtkSeparator* _tmp30_ = NULL;
	GtkButton* _tmp31_ = NULL;
	GtkImage* placeholder_image = NULL;
	GtkImage* _tmp32_ = NULL;
	GtkLabel* placeholder_label = NULL;
	GtkLabel* _tmp33_ = NULL;
	GtkBox* placeholder_box = NULL;
	GtkBox* _tmp34_ = NULL;
	GtkStyleContext* _tmp35_ = NULL;
	GtkListBox* _tmp36_ = NULL;
	g_return_val_if_fail (settings != NULL, NULL);
	g_return_val_if_fail (clipboard != NULL, NULL);
	self = (HasteAppletHistoryView*) g_object_new (object_type, "spacing", 0, "orientation", GTK_ORIENTATION_VERTICAL, NULL);
	gtk_widget_set_size_request ((GtkWidget*) self, 300, -1);
	_tmp0_ = settings;
	_tmp1_ = _g_object_ref0 (_tmp0_);
	_g_object_unref0 (self->priv->settings);
	self->priv->settings = _tmp1_;
	_tmp2_ = clipboard;
	_tmp3_ = _g_object_ref0 (_tmp2_);
	_g_object_unref0 (self->priv->clipboard);
	self->priv->clipboard = _tmp3_;
	_tmp4_ = (GtkLabel*) gtk_label_new ("<span font=\"11\">Recent Hastes</span>");
	g_object_ref_sink (_tmp4_);
	header_label = _tmp4_;
	gtk_label_set_use_markup (header_label, TRUE);
	gtk_widget_set_halign ((GtkWidget*) header_label, GTK_ALIGN_START);
	_tmp5_ = gtk_widget_get_style_context ((GtkWidget*) header_label);
	gtk_style_context_add_class (_tmp5_, "dim-label");
	_tmp6_ = (GtkButton*) gtk_button_new_with_label ("Add");
	g_object_ref_sink (_tmp6_);
	_g_object_unref0 (self->history_add_button);
	self->history_add_button = _tmp6_;
	_tmp7_ = self->history_add_button;
	gtk_widget_set_tooltip_text ((GtkWidget*) _tmp7_, "Add a new haste");
	_tmp8_ = self->history_add_button;
	gtk_widget_set_can_focus ((GtkWidget*) _tmp8_, FALSE);
	_tmp9_ = (GtkBox*) gtk_box_new (GTK_ORIENTATION_HORIZONTAL, 0);
	g_object_ref_sink (_tmp9_);
	header_sub_box = _tmp9_;
	g_object_set ((GtkWidget*) header_sub_box, "margin", 10, NULL);
	gtk_box_pack_start (header_sub_box, (GtkWidget*) header_label, TRUE, TRUE, (guint) 0);
	_tmp10_ = self->history_add_button;
	gtk_box_pack_start (header_sub_box, (GtkWidget*) _tmp10_, FALSE, FALSE, (guint) 0);
	_tmp11_ = (GtkBox*) gtk_box_new (GTK_ORIENTATION_VERTICAL, 0);
	g_object_ref_sink (_tmp11_);
	header_box = _tmp11_;
	gtk_box_pack_start (header_box, (GtkWidget*) header_sub_box, TRUE, TRUE, (guint) 0);
	_tmp12_ = (GtkSeparator*) gtk_separator_new (GTK_ORIENTATION_HORIZONTAL);
	g_object_ref_sink (_tmp12_);
	_tmp13_ = _tmp12_;
	gtk_box_pack_start (header_box, (GtkWidget*) _tmp13_, TRUE, TRUE, (guint) 0);
	_g_object_unref0 (_tmp13_);
	_tmp14_ = (GtkListBox*) gtk_list_box_new ();
	g_object_ref_sink (_tmp14_);
	_g_object_unref0 (self->priv->history_listbox);
	self->priv->history_listbox = _tmp14_;
	_tmp15_ = self->priv->history_listbox;
	gtk_list_box_set_selection_mode (_tmp15_, GTK_SELECTION_NONE);
	_tmp16_ = haste_applet_automatic_scroll_box_new (NULL, NULL);
	g_object_ref_sink (_tmp16_);
	history_scroller = _tmp16_;
	haste_applet_automatic_scroll_box_set_max_height (history_scroller, 265);
	gtk_scrolled_window_set_policy ((GtkScrolledWindow*) history_scroller, GTK_POLICY_NEVER, GTK_POLICY_AUTOMATIC);
	_tmp17_ = self->priv->history_listbox;
	gtk_container_add ((GtkContainer*) history_scroller, (GtkWidget*) _tmp17_);
	_tmp18_ = (GtkButton*) gtk_button_new_with_label ("Clear all Hastes");
	g_object_ref_sink (_tmp18_);
	_g_object_unref0 (self->priv->clear_all_button);
	self->priv->clear_all_button = _tmp18_;
	_tmp19_ = self->priv->clear_all_button;
	_tmp20_ = gtk_bin_get_child ((GtkBin*) _tmp19_);
	g_object_set (_tmp20_, "margin", 5, NULL);
	_tmp21_ = self->priv->clear_all_button;
	_tmp22_ = gtk_bin_get_child ((GtkBin*) _tmp21_);
	gtk_widget_set_margin_start (_tmp22_, 0);
	_tmp23_ = self->priv->clear_all_button;
	g_signal_connect_object (_tmp23_, "clicked", (GCallback) _haste_applet_history_view_clear_all_gtk_button_clicked, self, 0);
	_tmp24_ = self->priv->clear_all_button;
	gtk_widget_set_can_focus ((GtkWidget*) _tmp24_, FALSE);
	_tmp25_ = self->priv->clear_all_button;
	gtk_button_set_relief (_tmp25_, GTK_RELIEF_NONE);
	_tmp26_ = self->priv->clear_all_button;
	_tmp27_ = gtk_widget_get_style_context ((GtkWidget*) _tmp26_);
	gtk_style_context_add_class (_tmp27_, "bottom-button");
	_tmp28_ = (GtkBox*) gtk_box_new (GTK_ORIENTATION_VERTICAL, 0);
	g_object_ref_sink (_tmp28_);
	clear_all_box = _tmp28_;
	_tmp29_ = (GtkSeparator*) gtk_separator_new (GTK_ORIENTATION_HORIZONTAL);
	g_object_ref_sink (_tmp29_);
	_tmp30_ = _tmp29_;
	gtk_box_pack_start (clear_all_box, (GtkWidget*) _tmp30_, FALSE, FALSE, (guint) 0);
	_g_object_unref0 (_tmp30_);
	_tmp31_ = self->priv->clear_all_button;
	gtk_box_pack_end (clear_all_box, (GtkWidget*) _tmp31_, FALSE, TRUE, (guint) 0);
	_tmp32_ = (GtkImage*) gtk_image_new_from_icon_name ("action-unavailable-symbolic", GTK_ICON_SIZE_DIALOG);
	g_object_ref_sink (_tmp32_);
	placeholder_image = _tmp32_;
	gtk_image_set_pixel_size (placeholder_image, 64);
	_tmp33_ = (GtkLabel*) gtk_label_new ("<big>Nothing to see here</big>");
	g_object_ref_sink (_tmp33_);
	placeholder_label = _tmp33_;
	gtk_label_set_use_markup (placeholder_label, TRUE);
	_tmp34_ = (GtkBox*) gtk_box_new (GTK_ORIENTATION_VERTICAL, 6);
	g_object_ref_sink (_tmp34_);
	placeholder_box = _tmp34_;
	g_object_set ((GtkWidget*) placeholder_box, "margin", 40, NULL);
	_tmp35_ = gtk_widget_get_style_context ((GtkWidget*) placeholder_box);
	gtk_style_context_add_class (_tmp35_, "dim-label");
	gtk_widget_set_halign ((GtkWidget*) placeholder_box, GTK_ALIGN_CENTER);
	gtk_widget_set_valign ((GtkWidget*) placeholder_box, GTK_ALIGN_CENTER);
	gtk_box_pack_start (placeholder_box, (GtkWidget*) placeholder_image, FALSE, FALSE, (guint) 6);
	gtk_box_pack_start (placeholder_box, (GtkWidget*) placeholder_label, FALSE, FALSE, (guint) 0);
	_tmp36_ = self->priv->history_listbox;
	gtk_list_box_set_placeholder (_tmp36_, (GtkWidget*) placeholder_box);
	gtk_widget_show_all ((GtkWidget*) placeholder_box);
	gtk_box_pack_start ((GtkBox*) self, (GtkWidget*) header_box, FALSE, FALSE, (guint) 0);
	gtk_box_pack_start ((GtkBox*) self, (GtkWidget*) history_scroller, TRUE, TRUE, (guint) 0);
	gtk_box_pack_start ((GtkBox*) self, (GtkWidget*) clear_all_box, TRUE, TRUE, (guint) 0);
	gtk_widget_show_all ((GtkWidget*) self);
	haste_applet_history_view_update_child_count (self);
	_g_object_unref0 (placeholder_box);
	_g_object_unref0 (placeholder_label);
	_g_object_unref0 (placeholder_image);
	_g_object_unref0 (clear_all_box);
	_g_object_unref0 (history_scroller);
	_g_object_unref0 (header_box);
	_g_object_unref0 (header_sub_box);
	_g_object_unref0 (header_label);
	return self;
}


HasteAppletHistoryView* haste_applet_history_view_new (GSettings* settings, GtkClipboard* clipboard) {
	return haste_applet_history_view_construct (HASTE_APPLET_TYPE_HISTORY_VIEW, settings, clipboard);
}


void haste_applet_history_view_update_child_count (HasteAppletHistoryView* self) {
	guint len = 0U;
	GtkListBox* _tmp0_ = NULL;
	GList* _tmp1_ = NULL;
	GList* _tmp2_ = NULL;
	guint _tmp3_ = 0U;
	guint _tmp4_ = 0U;
	GtkButton* _tmp5_ = NULL;
	g_return_if_fail (self != NULL);
	_tmp0_ = self->priv->history_listbox;
	_tmp1_ = gtk_container_get_children ((GtkContainer*) _tmp0_);
	_tmp2_ = _tmp1_;
	_tmp3_ = g_list_length (_tmp2_);
	_tmp4_ = _tmp3_;
	_g_list_free0 (_tmp2_);
	len = _tmp4_;
	_tmp5_ = self->priv->clear_all_button;
	gtk_widget_set_sensitive ((GtkWidget*) _tmp5_, !(len == ((guint) 0)));
}


static void haste_applet_history_view_update_history_data_free (gpointer _data) {
	HasteAppletHistoryViewUpdateHistoryData* _data_;
	_data_ = _data;
	_g_object_unref0 (_data_->self);
	g_slice_free (HasteAppletHistoryViewUpdateHistoryData, _data_);
}


void haste_applet_history_view_update_history (HasteAppletHistoryView* self, gint n, gboolean startup, GAsyncReadyCallback _callback_, gpointer _user_data_) {
	HasteAppletHistoryViewUpdateHistoryData* _data_;
	HasteAppletHistoryView* _tmp0_ = NULL;
	gint _tmp1_ = 0;
	gboolean _tmp2_ = FALSE;
	_data_ = g_slice_new0 (HasteAppletHistoryViewUpdateHistoryData);
	_data_->_async_result = g_simple_async_result_new (G_OBJECT (self), _callback_, _user_data_, haste_applet_history_view_update_history);
	g_simple_async_result_set_op_res_gpointer (_data_->_async_result, _data_, haste_applet_history_view_update_history_data_free);
	_tmp0_ = _g_object_ref0 (self);
	_data_->self = _tmp0_;
	_tmp1_ = n;
	_data_->n = _tmp1_;
	_tmp2_ = startup;
	_data_->startup = _tmp2_;
	haste_applet_history_view_update_history_co (_data_);
}


void haste_applet_history_view_update_history_finish (HasteAppletHistoryView* self, GAsyncResult* _res_) {
	HasteAppletHistoryViewUpdateHistoryData* _data_;
	_data_ = g_simple_async_result_get_op_res_gpointer (G_SIMPLE_ASYNC_RESULT (_res_));
}


static Block4Data* block4_data_ref (Block4Data* _data4_) {
	g_atomic_int_inc (&_data4_->_ref_count_);
	return _data4_;
}


static void block4_data_unref (void * _userdata_) {
	Block4Data* _data4_;
	_data4_ = (Block4Data*) _userdata_;
	if (g_atomic_int_dec_and_test (&_data4_->_ref_count_)) {
		HasteAppletHistoryView* self;
		self = _data4_->self;
		_g_object_unref0 (_data4_->parent);
		_g_object_unref0 (self);
		g_slice_free (Block4Data, _data4_);
	}
}


static gboolean ___lambda15_ (HasteAppletHistoryView* self) {
	gboolean result = FALSE;
	HasteAppletHistoryViewItem* _tmp0_ = NULL;
	_tmp0_ = self->priv->history_view_item;
	gtk_revealer_set_reveal_child ((GtkRevealer*) _tmp0_, TRUE);
	result = TRUE;
	return result;
}


static gboolean ____lambda15__gsource_func (gpointer self) {
	gboolean result;
	result = ___lambda15_ ((HasteAppletHistoryView*) self);
	return result;
}


static void __lambda16_ (HasteAppletHistoryView* self, const gchar* url) {
	GtkClipboard* _tmp0_ = NULL;
	const gchar* _tmp1_ = NULL;
	g_return_if_fail (url != NULL);
	_tmp0_ = self->priv->clipboard;
	_tmp1_ = url;
	gtk_clipboard_set_text (_tmp0_, _tmp1_, -1);
}


static void ___lambda16__haste_applet_history_view_item_copy (HasteAppletHistoryViewItem* _sender, const gchar* url, gpointer self) {
	__lambda16_ ((HasteAppletHistoryView*) self, url);
}


static void __lambda17_ (Block4Data* _data4_) {
	HasteAppletHistoryView* self;
	gint index = 0;
	GtkListBoxRow* _tmp0_ = NULL;
	gint _tmp1_ = 0;
	GtkListBox* _tmp2_ = NULL;
	GList* _tmp3_ = NULL;
	GList* _tmp4_ = NULL;
	guint _tmp5_ = 0U;
	gboolean _tmp6_ = FALSE;
	gint _tmp8_ = 0;
	self = _data4_->self;
	_tmp0_ = _data4_->parent;
	_tmp1_ = gtk_list_box_row_get_index (_tmp0_);
	index = _tmp1_;
	_tmp2_ = self->priv->history_listbox;
	_tmp3_ = gtk_container_get_children ((GtkContainer*) _tmp2_);
	_tmp4_ = _tmp3_;
	_tmp5_ = g_list_length (_tmp4_);
	_tmp6_ = _tmp5_ == ((guint) 1);
	_g_list_free0 (_tmp4_);
	if (_tmp6_) {
		GtkListBoxRow* _tmp7_ = NULL;
		_tmp7_ = _data4_->parent;
		gtk_widget_destroy ((GtkWidget*) _tmp7_);
		haste_applet_history_view_update_child_count (self);
		return;
	}
	_tmp8_ = index;
	if (_tmp8_ == 0) {
		GtkWidget* row_after = NULL;
		GtkListBox* _tmp9_ = NULL;
		gint _tmp10_ = 0;
		GtkListBoxRow* _tmp11_ = NULL;
		GtkWidget* _tmp12_ = NULL;
		GtkWidget* _tmp13_ = NULL;
		_tmp9_ = self->priv->history_listbox;
		_tmp10_ = index;
		_tmp11_ = gtk_list_box_get_row_at_index (_tmp9_, _tmp10_ + 1);
		_tmp12_ = _g_object_ref0 ((GtkWidget*) _tmp11_);
		row_after = _tmp12_;
		_tmp13_ = row_after;
		if (_tmp13_ != NULL) {
			GtkWidget* _tmp14_ = NULL;
			_tmp14_ = row_after;
			gtk_widget_destroy (_tmp14_);
		}
		_g_object_unref0 (row_after);
	} else {
		GtkWidget* row_before = NULL;
		GtkListBox* _tmp15_ = NULL;
		gint _tmp16_ = 0;
		GtkListBoxRow* _tmp17_ = NULL;
		GtkWidget* _tmp18_ = NULL;
		GtkWidget* _tmp19_ = NULL;
		_tmp15_ = self->priv->history_listbox;
		_tmp16_ = index;
		_tmp17_ = gtk_list_box_get_row_at_index (_tmp15_, _tmp16_ - 1);
		_tmp18_ = _g_object_ref0 ((GtkWidget*) _tmp17_);
		row_before = _tmp18_;
		_tmp19_ = row_before;
		if (_tmp19_ != NULL) {
			GtkWidget* _tmp20_ = NULL;
			_tmp20_ = row_before;
			gtk_widget_destroy (_tmp20_);
		}
		_g_object_unref0 (row_before);
	}
	haste_applet_history_view_update_child_count (self);
}


static void ___lambda17__haste_applet_history_view_item_deletion (HasteAppletHistoryViewItem* _sender, gpointer self) {
	__lambda17_ (self);
}


static gboolean haste_applet_history_view_update_history_co (HasteAppletHistoryViewUpdateHistoryData* _data_) {
	switch (_data_->_state_) {
		case 0:
		goto _state_0;
		default:
		g_assert_not_reached ();
	}
	_state_0:
	_data_->_data4_ = g_slice_new0 (Block4Data);
	_data_->_data4_->_ref_count_ = 1;
	_data_->_data4_->self = g_object_ref (_data_->self);
	_data_->_data4_->_async_data_ = _data_;
	_data_->separator_item = NULL;
	_data_->_tmp0_ = NULL;
	_data_->_tmp0_ = _data_->self->priv->history_listbox;
	_data_->_tmp1_ = NULL;
	_data_->_tmp1_ = gtk_container_get_children ((GtkContainer*) _data_->_tmp0_);
	_data_->_tmp2_ = NULL;
	_data_->_tmp2_ = _data_->_tmp1_;
	_data_->_tmp3_ = 0U;
	_data_->_tmp3_ = g_list_length (_data_->_tmp2_);
	_data_->_tmp4_ = FALSE;
	_data_->_tmp4_ = _data_->_tmp3_ != ((guint) 0);
	_g_list_free0 (_data_->_tmp2_);
	if (_data_->_tmp4_) {
		_data_->_tmp5_ = NULL;
		_data_->_tmp5_ = (GtkSeparator*) gtk_separator_new (GTK_ORIENTATION_HORIZONTAL);
		g_object_ref_sink (_data_->_tmp5_);
		_data_->separator = _data_->_tmp5_;
		_data_->_tmp6_ = NULL;
		_data_->_tmp6_ = (GtkListBoxRow*) gtk_list_box_row_new ();
		g_object_ref_sink (_data_->_tmp6_);
		_g_object_unref0 (_data_->separator_item);
		_data_->separator_item = _data_->_tmp6_;
		_data_->_tmp7_ = NULL;
		_data_->_tmp7_ = _data_->separator;
		_data_->_tmp8_ = NULL;
		_data_->_tmp8_ = _data_->separator_item;
		gtk_list_box_row_set_selectable (_data_->_tmp8_, FALSE);
		gtk_widget_set_can_focus ((GtkWidget*) _data_->_tmp7_, FALSE);
		_data_->_tmp9_ = NULL;
		_data_->_tmp9_ = _data_->separator_item;
		_data_->_tmp10_ = NULL;
		_data_->_tmp10_ = _data_->separator_item;
		gtk_list_box_row_set_activatable (_data_->_tmp10_, FALSE);
		gtk_widget_set_can_focus ((GtkWidget*) _data_->_tmp9_, FALSE);
		_data_->_tmp11_ = NULL;
		_data_->_tmp11_ = _data_->separator_item;
		_data_->_tmp12_ = NULL;
		_data_->_tmp12_ = _data_->separator;
		gtk_container_add ((GtkContainer*) _data_->_tmp11_, (GtkWidget*) _data_->_tmp12_);
		_data_->_tmp13_ = NULL;
		_data_->_tmp13_ = _data_->self->priv->history_listbox;
		_data_->_tmp14_ = NULL;
		_data_->_tmp14_ = _data_->separator_item;
		gtk_list_box_prepend (_data_->_tmp13_, (GtkWidget*) _data_->_tmp14_);
		_g_object_unref0 (_data_->separator);
	}
	_data_->_tmp15_ = 0;
	_data_->_tmp15_ = _data_->n;
	_data_->_tmp16_ = NULL;
	_data_->_tmp16_ = _data_->self->priv->settings;
	_data_->_tmp17_ = NULL;
	_data_->_tmp17_ = haste_applet_history_view_item_new (_data_->_tmp15_, _data_->_tmp16_);
	g_object_ref_sink (_data_->_tmp17_);
	_g_object_unref0 (_data_->self->priv->history_view_item);
	_data_->self->priv->history_view_item = _data_->_tmp17_;
	_data_->_tmp18_ = NULL;
	_data_->_tmp18_ = _data_->self->priv->history_listbox;
	_data_->_tmp19_ = NULL;
	_data_->_tmp19_ = _data_->self->priv->history_view_item;
	gtk_list_box_prepend (_data_->_tmp18_, (GtkWidget*) _data_->_tmp19_);
	_data_->_tmp20_ = NULL;
	_data_->_tmp20_ = _data_->self->priv->history_view_item;
	_data_->_tmp21_ = NULL;
	_data_->_tmp21_ = (GtkContainer*) gtk_widget_get_parent ((GtkWidget*) _data_->_tmp20_);
	_data_->_tmp22_ = NULL;
	_data_->_tmp22_ = _g_object_ref0 (G_TYPE_CHECK_INSTANCE_CAST (_data_->_tmp21_, gtk_list_box_row_get_type (), GtkListBoxRow));
	_data_->_data4_->parent = _data_->_tmp22_;
	_data_->_tmp23_ = NULL;
	_data_->_tmp23_ = _data_->_data4_->parent;
	gtk_list_box_row_set_selectable (_data_->_tmp23_, FALSE);
	_data_->_tmp24_ = NULL;
	_data_->_tmp24_ = _data_->_data4_->parent;
	gtk_widget_set_can_focus ((GtkWidget*) _data_->_tmp24_, FALSE);
	_data_->_tmp25_ = NULL;
	_data_->_tmp25_ = _data_->_data4_->parent;
	gtk_list_box_row_set_activatable (_data_->_tmp25_, FALSE);
	_data_->_tmp26_ = NULL;
	_data_->_tmp26_ = _data_->self->priv->history_listbox;
	gtk_widget_show_all ((GtkWidget*) _data_->_tmp26_);
	_data_->_tmp27_ = FALSE;
	_data_->_tmp27_ = _data_->startup;
	if (_data_->_tmp27_) {
		_data_->_tmp28_ = NULL;
		_data_->_tmp28_ = _data_->self->priv->history_view_item;
		gtk_revealer_set_reveal_child ((GtkRevealer*) _data_->_tmp28_, TRUE);
	} else {
		_data_->_tmp29_ = NULL;
		_data_->_tmp29_ = _data_->self->priv->history_view_item;
		gtk_revealer_set_transition_type ((GtkRevealer*) _data_->_tmp29_, GTK_REVEALER_TRANSITION_TYPE_SLIDE_UP);
		g_timeout_add_full (G_PRIORITY_DEFAULT, (guint) 1, ____lambda15__gsource_func, g_object_ref (_data_->self), g_object_unref);
	}
	_data_->_tmp30_ = NULL;
	_data_->_tmp30_ = _data_->self->priv->history_view_item;
	g_signal_connect_object (_data_->_tmp30_, "copy", (GCallback) ___lambda16__haste_applet_history_view_item_copy, _data_->self, 0);
	_data_->_tmp31_ = NULL;
	_data_->_tmp31_ = _data_->self->priv->history_view_item;
	g_signal_connect_data (_data_->_tmp31_, "deletion", (GCallback) ___lambda17__haste_applet_history_view_item_deletion, block4_data_ref (_data_->_data4_), (GClosureNotify) block4_data_unref, 0);
	haste_applet_history_view_update_child_count (_data_->self);
	_g_object_unref0 (_data_->separator_item);
	block4_data_unref (_data_->_data4_);
	_data_->_data4_ = NULL;
	if (_data_->_state_ == 0) {
		g_simple_async_result_complete_in_idle (_data_->_async_result);
	} else {
		g_simple_async_result_complete (_data_->_async_result);
	}
	g_object_unref (_data_->_async_result);
	return FALSE;
}


static gpointer _g_variant_ref0 (gpointer self) {
	return self ? g_variant_ref (self) : NULL;
}


static void _vala_array_add1 (GVariant*** array, int* length, int* size, GVariant* value) {
	if ((*length) == (*size)) {
		*size = (*size) ? (2 * (*size)) : 4;
		*array = g_renew (GVariant*, *array, (*size) + 1);
	}
	(*array)[(*length)++] = value;
	(*array)[*length] = NULL;
}


static void _vala_array_add2 (GVariant*** array, int* length, int* size, GVariant* value) {
	if ((*length) == (*size)) {
		*size = (*size) ? (2 * (*size)) : 4;
		*array = g_renew (GVariant*, *array, (*size) + 1);
	}
	(*array)[(*length)++] = value;
	(*array)[*length] = NULL;
}


void haste_applet_history_view_add_to_history (HasteAppletHistoryView* self, const gchar* link, const gchar* title) {
	GVariant* history_list = NULL;
	GSettings* _tmp0_ = NULL;
	GVariant* _tmp1_ = NULL;
	GDateTime* datetime = NULL;
	GDateTime* _tmp2_ = NULL;
	gint64 timestamp = 0LL;
	GDateTime* _tmp3_ = NULL;
	gint64 _tmp4_ = 0LL;
	const gchar* _tmp5_ = NULL;
	GVariant* timestamp_variant = NULL;
	gint64 _tmp6_ = 0LL;
	GVariant* _tmp7_ = NULL;
	GVariant* title_variant = NULL;
	const gchar* _tmp8_ = NULL;
	GVariant* _tmp9_ = NULL;
	GVariant* link_variant = NULL;
	const gchar* _tmp10_ = NULL;
	GVariant* _tmp11_ = NULL;
	GVariant** history_variant_list = NULL;
	gint history_variant_list_length1 = 0;
	gint _history_variant_list_size_ = 0;
	GVariant* history_entry_tuple = NULL;
	GVariant* _tmp23_ = NULL;
	GVariant* _tmp24_ = NULL;
	GVariant* _tmp25_ = NULL;
	GVariant* _tmp26_ = NULL;
	GVariant* _tmp27_ = NULL;
	GVariant* _tmp28_ = NULL;
	GVariant** _tmp29_ = NULL;
	GVariant** _tmp30_ = NULL;
	gint _tmp30__length1 = 0;
	GVariant* _tmp31_ = NULL;
	GVariant* _tmp32_ = NULL;
	GVariant** _tmp33_ = NULL;
	gint _tmp33__length1 = 0;
	GVariant* _tmp34_ = NULL;
	GVariant* history_entry_array = NULL;
	GVariant** _tmp35_ = NULL;
	gint _tmp35__length1 = 0;
	GVariant* _tmp36_ = NULL;
	GSettings* _tmp37_ = NULL;
	GVariant** _tmp38_ = NULL;
	gint _tmp38__length1 = 0;
	g_return_if_fail (self != NULL);
	g_return_if_fail (link != NULL);
	g_return_if_fail (title != NULL);
	_tmp0_ = self->priv->settings;
	_tmp1_ = g_settings_get_value (_tmp0_, "history");
	history_list = _tmp1_;
	_tmp2_ = g_date_time_new_now_local ();
	datetime = _tmp2_;
	_tmp3_ = datetime;
	_tmp4_ = g_date_time_to_unix (_tmp3_);
	timestamp = _tmp4_;
	_tmp5_ = title;
	if (g_strcmp0 (_tmp5_, "") == 0) {
		title = "Untitled";
	}
	_tmp6_ = timestamp;
	_tmp7_ = g_variant_new_int64 (_tmp6_);
	g_variant_ref_sink (_tmp7_);
	timestamp_variant = _tmp7_;
	_tmp8_ = title;
	_tmp9_ = g_variant_new_string (_tmp8_);
	g_variant_ref_sink (_tmp9_);
	title_variant = _tmp9_;
	_tmp10_ = link;
	_tmp11_ = g_variant_new_string (_tmp10_);
	g_variant_ref_sink (_tmp11_);
	link_variant = _tmp11_;
	history_variant_list = NULL;
	history_variant_list_length1 = 0;
	_history_variant_list_size_ = history_variant_list_length1;
	{
		gint i = 0;
		i = 0;
		{
			gboolean _tmp12_ = FALSE;
			_tmp12_ = TRUE;
			while (TRUE) {
				gint _tmp14_ = 0;
				GVariant* _tmp15_ = NULL;
				gsize _tmp16_ = 0UL;
				GVariant* history_variant = NULL;
				GVariant* _tmp17_ = NULL;
				gint _tmp18_ = 0;
				GVariant* _tmp19_ = NULL;
				GVariant** _tmp20_ = NULL;
				gint _tmp20__length1 = 0;
				GVariant* _tmp21_ = NULL;
				GVariant* _tmp22_ = NULL;
				if (!_tmp12_) {
					gint _tmp13_ = 0;
					_tmp13_ = i;
					i = _tmp13_ + 1;
				}
				_tmp12_ = FALSE;
				_tmp14_ = i;
				_tmp15_ = history_list;
				_tmp16_ = g_variant_n_children (_tmp15_);
				if (!(((gsize) _tmp14_) < _tmp16_)) {
					break;
				}
				_tmp17_ = history_list;
				_tmp18_ = i;
				_tmp19_ = g_variant_get_child_value (_tmp17_, (gsize) _tmp18_);
				history_variant = _tmp19_;
				_tmp20_ = history_variant_list;
				_tmp20__length1 = history_variant_list_length1;
				_tmp21_ = history_variant;
				_tmp22_ = _g_variant_ref0 (_tmp21_);
				_vala_array_add1 (&history_variant_list, &history_variant_list_length1, &_history_variant_list_size_, _tmp22_);
				_g_variant_unref0 (history_variant);
			}
		}
	}
	_tmp23_ = timestamp_variant;
	_tmp24_ = _g_variant_ref0 (_tmp23_);
	_tmp25_ = title_variant;
	_tmp26_ = _g_variant_ref0 (_tmp25_);
	_tmp27_ = link_variant;
	_tmp28_ = _g_variant_ref0 (_tmp27_);
	_tmp29_ = g_new0 (GVariant*, 3 + 1);
	_tmp29_[0] = _tmp24_;
	_tmp29_[1] = _tmp26_;
	_tmp29_[2] = _tmp28_;
	_tmp30_ = _tmp29_;
	_tmp30__length1 = 3;
	_tmp31_ = g_variant_new_tuple (_tmp30_, 3);
	g_variant_ref_sink (_tmp31_);
	_tmp32_ = _tmp31_;
	_tmp30_ = (_vala_array_free (_tmp30_, _tmp30__length1, (GDestroyNotify) g_variant_unref), NULL);
	history_entry_tuple = _tmp32_;
	_tmp33_ = history_variant_list;
	_tmp33__length1 = history_variant_list_length1;
	_tmp34_ = _g_variant_ref0 (history_entry_tuple);
	_vala_array_add2 (&history_variant_list, &history_variant_list_length1, &_history_variant_list_size_, _tmp34_);
	_tmp35_ = history_variant_list;
	_tmp35__length1 = history_variant_list_length1;
	_tmp36_ = g_variant_new_array (NULL, _tmp35_, _tmp35__length1);
	g_variant_ref_sink (_tmp36_);
	history_entry_array = _tmp36_;
	_tmp37_ = self->priv->settings;
	g_settings_set_value (_tmp37_, "history", history_entry_array);
	_tmp38_ = history_variant_list;
	_tmp38__length1 = history_variant_list_length1;
	haste_applet_history_view_update_history (self, _tmp38__length1 - 1, FALSE, NULL, NULL);
	_g_variant_unref0 (history_entry_array);
	_g_variant_unref0 (history_entry_tuple);
	history_variant_list = (_vala_array_free (history_variant_list, history_variant_list_length1, (GDestroyNotify) g_variant_unref), NULL);
	_g_variant_unref0 (link_variant);
	_g_variant_unref0 (title_variant);
	_g_variant_unref0 (timestamp_variant);
	_g_date_time_unref0 (datetime);
	_g_variant_unref0 (history_list);
}


void haste_applet_history_view_clear_all (HasteAppletHistoryView* self) {
	GSettings* _tmp0_ = NULL;
	GtkListBox* _tmp1_ = NULL;
	GList* _tmp2_ = NULL;
	g_return_if_fail (self != NULL);
	_tmp0_ = self->priv->settings;
	g_settings_reset (_tmp0_, "history");
	_tmp1_ = self->priv->history_listbox;
	_tmp2_ = gtk_container_get_children ((GtkContainer*) _tmp1_);
	{
		GList* child_collection = NULL;
		GList* child_it = NULL;
		child_collection = _tmp2_;
		for (child_it = child_collection; child_it != NULL; child_it = child_it->next) {
			GtkWidget* _tmp3_ = NULL;
			GtkWidget* child = NULL;
			_tmp3_ = _g_object_ref0 ((GtkWidget*) child_it->data);
			child = _tmp3_;
			{
				GtkWidget* _tmp4_ = NULL;
				_tmp4_ = child;
				gtk_widget_destroy (_tmp4_);
				_g_object_unref0 (child);
			}
		}
		_g_list_free0 (child_collection);
	}
	haste_applet_history_view_update_child_count (self);
}


static void haste_applet_history_view_class_init (HasteAppletHistoryViewClass * klass) {
	haste_applet_history_view_parent_class = g_type_class_peek_parent (klass);
	g_type_class_add_private (klass, sizeof (HasteAppletHistoryViewPrivate));
	G_OBJECT_CLASS (klass)->finalize = haste_applet_history_view_finalize;
}


static void haste_applet_history_view_instance_init (HasteAppletHistoryView * self) {
	self->priv = HASTE_APPLET_HISTORY_VIEW_GET_PRIVATE (self);
}


static void haste_applet_history_view_finalize (GObject* obj) {
	HasteAppletHistoryView * self;
	self = G_TYPE_CHECK_INSTANCE_CAST (obj, HASTE_APPLET_TYPE_HISTORY_VIEW, HasteAppletHistoryView);
	_g_object_unref0 (self->priv->clear_all_button);
	_g_object_unref0 (self->priv->history_listbox);
	_g_object_unref0 (self->priv->clipboard);
	_g_object_unref0 (self->priv->settings);
	_g_object_unref0 (self->priv->history_view_item);
	_g_object_unref0 (self->history_add_button);
	G_OBJECT_CLASS (haste_applet_history_view_parent_class)->finalize (obj);
}


GType haste_applet_history_view_get_type (void) {
	return haste_applet_history_view_type_id;
}


GType haste_applet_history_view_register_type (GTypeModule * module) {
	static const GTypeInfo g_define_type_info = { sizeof (HasteAppletHistoryViewClass), (GBaseInitFunc) NULL, (GBaseFinalizeFunc) NULL, (GClassInitFunc) haste_applet_history_view_class_init, (GClassFinalizeFunc) NULL, NULL, sizeof (HasteAppletHistoryView), 0, (GInstanceInitFunc) haste_applet_history_view_instance_init, NULL };
	haste_applet_history_view_type_id = g_type_module_register_type (module, gtk_box_get_type (), "HasteAppletHistoryView", &g_define_type_info, 0);
	return haste_applet_history_view_type_id;
}


static void _vala_array_destroy (gpointer array, gint array_length, GDestroyNotify destroy_func) {
	if ((array != NULL) && (destroy_func != NULL)) {
		int i;
		for (i = 0; i < array_length; i = i + 1) {
			if (((gpointer*) array)[i] != NULL) {
				destroy_func (((gpointer*) array)[i]);
			}
		}
	}
}


static void _vala_array_free (gpointer array, gint array_length, GDestroyNotify destroy_func) {
	_vala_array_destroy (array, array_length, destroy_func);
	g_free (array);
}



