-- This file contains the API for the check package. The API is
-- common to all implementations of the check functionality (VHDL 2002+ and VHDL 1993)
--
-- This Source Code Form is subject to the terms of the Mozilla Public
-- License, v. 2.0. If a copy of the MPL was not distributed with this file,
-- You can obtain one at http://mozilla.org/MPL/2.0/.
--
-- Copyright (c) 2014-2017, Lars Asplund lars.anders.asplund@gmail.com

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;
use work.checker_pkg.all;
use work.logger_pkg.all;
use work.log_levels_pkg.all;

package check_pkg is
  signal check_enabled : std_logic := '1';

  constant check_result_tag_c : string := "<+/->";
  constant default_checker : checker_t := new_checker("");
  constant check_logger : logger_t := get_logger(default_checker);

  procedure get_checker_stat (variable stat : out checker_stat_t);
  impure function get_checker_stat return checker_stat_t;
  procedure reset_checker_stat;

  function result (msg : string := "") return string;

  -----------------------------------------------------------------------------
  -- check
  -----------------------------------------------------------------------------
  procedure check(
    checker                    :    checker_t;
    signal clock               : in std_logic;
    signal en                  : in std_logic;
    signal expr                : in std_logic;
    constant msg               : in string                 := check_result_tag_c & ".";
    constant level             : in log_level_t := null_log_level;
    constant active_clock_edge : in edge_t                 := rising_edge;
    constant line_num          : in natural                := 0;
    constant file_name         : in string                 := "");

  procedure check(
    checker            :     checker_t;
    variable pass      : out boolean;
    constant expr      : in  boolean;
    constant msg       : in  string                 := check_result_tag_c & ".";
    constant level     : in  log_level_t := null_log_level;
    constant line_num  : in  natural                := 0;
    constant file_name : in  string                 := "");

  procedure check(
    checker            :    checker_t;
    constant expr      : in boolean;
    constant msg       : in string                 := check_result_tag_c & ".";
    constant level     : in log_level_t := null_log_level;
    constant line_num  : in natural                := 0;
    constant file_name : in string                 := "");

  procedure check(
    constant expr      : in boolean;
    constant msg       : in string                 := check_result_tag_c & ".";
    constant level     : in log_level_t := null_log_level;
    constant line_num  : in natural                := 0;
    constant file_name : in string                 := "");

  procedure check(
    variable pass      : out boolean;
    constant expr      : in  boolean;
    constant msg       : in  string                 := check_result_tag_c & ".";
    constant level     : in  log_level_t := null_log_level;
    constant line_num  : in  natural                := 0;
    constant file_name : in  string                 := "");

  impure function check(
    constant expr      : in boolean;
    constant msg       : in string                 := check_result_tag_c & ".";
    constant level     : in log_level_t := null_log_level;
    constant line_num  : in natural                := 0;
    constant file_name : in string                 := "")
    return boolean;

  procedure check(
    signal clock               : in std_logic;
    signal en                  : in std_logic;
    signal expr                : in std_logic;
    constant msg               : in string                 := check_result_tag_c & ".";
    constant level             : in log_level_t := null_log_level;
    constant active_clock_edge : in edge_t                 := rising_edge;
    constant line_num          : in natural                := 0;
    constant file_name         : in string                 := "");

  -----------------------------------------------------------------------------
  -- check_passed
  -----------------------------------------------------------------------------
  procedure check_passed(
    checker            :    checker_t;
    constant msg       : in string  := check_result_tag_c & ".";
    constant line_num  : in natural := 0;
    constant file_name : in string  := "");

  procedure check_passed(
    constant msg       : in string  := check_result_tag_c & ".";
    constant line_num  : in natural := 0;
    constant file_name : in string  := "");

  -----------------------------------------------------------------------------
  -- check_failed
  -----------------------------------------------------------------------------
  procedure check_failed(
    checker            :    checker_t;
    constant msg       : in string                 := check_result_tag_c & ".";
    constant level     : in log_level_t := null_log_level;
    constant line_num  : in natural                := 0;
    constant file_name : in string                 := "");

  procedure check_failed(
    constant msg       : in string                 := check_result_tag_c & ".";
    constant level     : in log_level_t := null_log_level;
    constant line_num  : in natural                := 0;
    constant file_name : in string                 := "");

  -----------------------------------------------------------------------------
  -- check_true
  -----------------------------------------------------------------------------
  procedure check_true(
    checker                    :    checker_t;
    signal clock               : in std_logic;
    signal en                  : in std_logic;
    signal expr                : in std_logic;
    constant msg               : in string                 := check_result_tag_c & ".";
    constant level             : in log_level_t := null_log_level;
    constant active_clock_edge : in edge_t                 := rising_edge;
    constant line_num          : in natural                := 0;
    constant file_name         : in string                 := "");

  procedure check_true(
    checker            :     checker_t;
    variable pass      : out boolean;
    constant expr      : in  boolean;
    constant msg       : in  string                 := check_result_tag_c & ".";
    constant level     : in  log_level_t := null_log_level;
    constant line_num  : in  natural                := 0;
    constant file_name : in  string                 := "");

  procedure check_true(
    checker            :    checker_t;
    constant expr      : in boolean;
    constant msg       : in string                 := check_result_tag_c & ".";
    constant level     : in log_level_t := null_log_level;
    constant line_num  : in natural                := 0;
    constant file_name : in string                 := "");

  procedure check_true(
    constant expr      : in boolean;
    constant msg       : in string                 := check_result_tag_c & ".";
    constant level     : in log_level_t := null_log_level;
    constant line_num  : in natural                := 0;
    constant file_name : in string                 := "");

  procedure check_true(
    variable pass      : out boolean;
    constant expr      : in  boolean;
    constant msg       : in  string                 := check_result_tag_c & ".";
    constant level     : in  log_level_t := null_log_level;
    constant line_num  : in  natural                := 0;
    constant file_name : in  string                 := "");

  impure function check_true(
    constant expr      : in boolean;
    constant msg       : in string                 := check_result_tag_c & ".";
    constant level     : in log_level_t := null_log_level;
    constant line_num  : in natural                := 0;
    constant file_name : in string                 := "")
    return boolean;

  procedure check_true(
    signal clock               : in std_logic;
    signal en                  : in std_logic;
    signal expr                : in std_logic;
    constant msg               : in string                 := check_result_tag_c & ".";
    constant level             : in log_level_t := null_log_level;
    constant active_clock_edge : in edge_t                 := rising_edge;
    constant line_num          : in natural                := 0;
    constant file_name         : in string                 := "");

  -----------------------------------------------------------------------------
  -- check_false
  -----------------------------------------------------------------------------
  procedure check_false(
    checker            :    checker_t;
    constant expr      : in boolean;
    constant msg       : in string                 := check_result_tag_c & ".";
    constant level     : in log_level_t := null_log_level;
    constant line_num  : in natural                := 0;
    constant file_name : in string                 := "");

  procedure check_false(
    checker            :     checker_t;
    variable pass      : out boolean;
    constant expr      : in  boolean;
    constant msg       : in  string                 := check_result_tag_c & ".";
    constant level     : in  log_level_t := null_log_level;
    constant line_num  : in  natural                := 0;
    constant file_name : in  string                 := "");

  procedure check_false(
    checker                    :    checker_t;
    signal clock               : in std_logic;
    signal en                  : in std_logic;
    signal expr                : in std_logic;
    constant msg               : in string                 := check_result_tag_c & ".";
    constant level             : in log_level_t := null_log_level;
    constant active_clock_edge : in edge_t                 := rising_edge;
    constant line_num          : in natural                := 0;
    constant file_name         : in string                 := "");

  procedure check_false(
    constant expr      : in boolean;
    constant msg       : in string                 := check_result_tag_c & ".";
    constant level     : in log_level_t := null_log_level;
    constant line_num  : in natural                := 0;
    constant file_name : in string                 := "");

  procedure check_false(
    variable pass      : out boolean;
    constant expr      : in  boolean;
    constant msg       : in  string                 := check_result_tag_c & ".";
    constant level     : in  log_level_t := null_log_level;
    constant line_num  : in  natural                := 0;
    constant file_name : in  string                 := "");

  impure function check_false(
    constant expr      : in boolean;
    constant msg       : in string                 := check_result_tag_c & ".";
    constant level     : in log_level_t := null_log_level;
    constant line_num  : in natural                := 0;
    constant file_name : in string                 := "")
    return boolean;

  procedure check_false(
    signal clock               : in std_logic;
    signal en                  : in std_logic;
    signal expr                : in std_logic;
    constant msg               : in string                 := check_result_tag_c & ".";
    constant level             : in log_level_t := null_log_level;
    constant active_clock_edge : in edge_t                 := rising_edge;
    constant line_num          : in natural                := 0;
    constant file_name         : in string                 := "");

  -----------------------------------------------------------------------------
  -- check_implication
  -----------------------------------------------------------------------------
  procedure check_implication(
    checker                    :    checker_t;
    signal clock               : in std_logic;
    signal en                  : in std_logic;
    signal antecedent_expr     : in std_logic;
    signal consequent_expr     : in std_logic;
    constant msg               : in string                 := check_result_tag_c & ".";
    constant level             : in log_level_t := null_log_level;
    constant active_clock_edge : in edge_t                 := rising_edge;
    constant line_num          : in natural                := 0;
    constant file_name         : in string                 := "");

  procedure check_implication(
    signal clock               : in std_logic;
    signal en                  : in std_logic;
    signal antecedent_expr     : in std_logic;
    signal consequent_expr     : in std_logic;
    constant msg               : in string                 := check_result_tag_c & ".";
    constant level             : in log_level_t := null_log_level;
    constant active_clock_edge : in edge_t                 := rising_edge;
    constant line_num          : in natural                := 0;
    constant file_name         : in string                 := "");

  procedure check_implication(
    checker                  :    checker_t;
    constant antecedent_expr : in boolean;
    constant consequent_expr : in boolean;
    constant msg             : in string                 := check_result_tag_c & ".";
    constant level           : in log_level_t := null_log_level;
    constant line_num        : in natural                := 0;
    constant file_name       : in string                 := "");

  procedure check_implication(
    checker                  :     checker_t;
    variable pass            : out boolean;
    constant antecedent_expr : in  boolean;
    constant consequent_expr : in  boolean;
    constant msg             : in  string                 := check_result_tag_c & ".";
    constant level           : in  log_level_t := null_log_level;
    constant line_num        : in  natural                := 0;
    constant file_name       : in  string                 := "");

  procedure check_implication(
    constant antecedent_expr : in boolean;
    constant consequent_expr : in boolean;
    constant msg             : in string                 := check_result_tag_c & ".";
    constant level           : in log_level_t := null_log_level;
    constant line_num        : in natural                := 0;
    constant file_name       : in string                 := "");

  procedure check_implication(
    variable pass            : out boolean;
    constant antecedent_expr : in  boolean;
    constant consequent_expr : in  boolean;
    constant msg             : in  string                 := check_result_tag_c & ".";
    constant level           : in  log_level_t := null_log_level;
    constant line_num        : in  natural                := 0;
    constant file_name       : in  string                 := "");

  impure function check_implication(
    constant antecedent_expr : in boolean;
    constant consequent_expr : in boolean;
    constant msg             : in string                 := check_result_tag_c & ".";
    constant level           : in log_level_t := null_log_level;
    constant line_num        : in natural                := 0;
    constant file_name       : in string                 := "")
    return boolean;

  -----------------------------------------------------------------------------
  -- check_stable
  -----------------------------------------------------------------------------
  procedure check_stable(
    checker                    :    checker_t;
    signal clock               : in std_logic;
    signal en                  : in std_logic;
    signal start_event         : in std_logic;
    signal end_event           : in std_logic;
    signal expr                : in std_logic_vector;
    constant msg               : in string                 := check_result_tag_c;
    constant level             : in log_level_t := null_log_level;
    constant active_clock_edge : in edge_t                 := rising_edge;
    constant allow_restart     : in    boolean     := false;
    constant line_num          : in    natural     := 0;
    constant file_name         : in string                 := "");

  procedure check_stable(
    signal clock               : in std_logic;
    signal en                  : in std_logic;
    signal start_event         : in std_logic;
    signal end_event           : in std_logic;
    signal expr                : in std_logic_vector;
    constant msg               : in string                 := check_result_tag_c;
    constant level             : in log_level_t := null_log_level;
    constant active_clock_edge : in edge_t                 := rising_edge;
    constant allow_restart     : in boolean     := false;
    constant line_num          : in natural     := 0;
    constant file_name         : in string                 := "");

  procedure check_stable(
    checker                    :    checker_t;
    signal clock               : in std_logic;
    signal en                  : in std_logic;
    signal start_event         : in std_logic;
    signal end_event           : in std_logic;
    signal expr                : in std_logic;
    constant msg               : in string                 := check_result_tag_c;
    constant level             : in log_level_t := null_log_level;
    constant active_clock_edge : in edge_t                 := rising_edge;
    constant allow_restart     : in    boolean     := false;
    constant line_num          : in    natural     := 0;
    constant file_name         : in string                 := "");

  procedure check_stable(
    signal clock               : in std_logic;
    signal en                  : in std_logic;
    signal start_event         : in std_logic;
    signal end_event           : in std_logic;
    signal expr                : in std_logic;
    constant msg               : in string                 := check_result_tag_c;
    constant level             : in log_level_t := null_log_level;
    constant active_clock_edge : in edge_t                 := rising_edge;
    constant allow_restart     : in boolean     := false;
    constant line_num          : in natural     := 0;
    constant file_name         : in string                 := "");

  -------------------------------------------------------------------------------
  -- check_not_unknown
  -------------------------------------------------------------------------------
  procedure check_not_unknown(
    checker                    :    checker_t;
    signal clock               : in std_logic;
    signal en                  : in std_logic;
    signal expr                : in std_logic_vector;
    constant msg               : in string                 := check_result_tag_c;
    constant level             : in log_level_t := null_log_level;
    constant active_clock_edge : in edge_t                 := rising_edge;
    constant line_num          : in natural                := 0;
    constant file_name         : in string                 := "");

  procedure check_not_unknown(
    signal clock               : in std_logic;
    signal en                  : in std_logic;
    signal expr                : in std_logic_vector;
    constant msg               : in string                 := check_result_tag_c;
    constant level             : in log_level_t := null_log_level;
    constant active_clock_edge : in edge_t                 := rising_edge;
    constant line_num          : in natural                := 0;
    constant file_name         : in string                 := "");

  procedure check_not_unknown(
    checker            :    checker_t;
    constant expr      : in std_logic_vector;
    constant msg       : in string                 := check_result_tag_c;
    constant level     : in log_level_t := null_log_level;
    constant line_num  : in natural                := 0;
    constant file_name : in string                 := "");

  procedure check_not_unknown(
    checker            :     checker_t;
    variable pass      : out boolean;
    constant expr      : in  std_logic_vector;
    constant msg       : in  string                 := check_result_tag_c;
    constant level     : in  log_level_t := null_log_level;
    constant line_num  : in  natural                := 0;
    constant file_name : in  string                 := "");

  procedure check_not_unknown(
    constant expr      : in std_logic_vector;
    constant msg       : in string                 := check_result_tag_c;
    constant level     : in log_level_t := null_log_level;
    constant line_num  : in natural                := 0;
    constant file_name : in string                 := "");

  procedure check_not_unknown(
    variable pass      : out boolean;
    constant expr      : in  std_logic_vector;
    constant msg       : in  string                 := check_result_tag_c;
    constant level     : in  log_level_t := null_log_level;
    constant line_num  : in  natural                := 0;
    constant file_name : in  string                 := "");

  impure function check_not_unknown(
    constant expr      : in std_logic_vector;
    constant msg       : in string                 := check_result_tag_c;
    constant level     : in log_level_t := null_log_level;
    constant line_num  : in natural                := 0;
    constant file_name : in string                 := "")
    return boolean;

  procedure check_not_unknown(
    checker                    :    checker_t;
    signal clock               : in std_logic;
    signal en                  : in std_logic;
    signal expr                : in std_logic;
    constant msg               : in string                 := check_result_tag_c;
    constant level             : in log_level_t := null_log_level;
    constant active_clock_edge : in edge_t                 := rising_edge;
    constant line_num          : in natural                := 0;
    constant file_name         : in string                 := "");

  procedure check_not_unknown(
    signal clock               : in std_logic;
    signal en                  : in std_logic;
    signal expr                : in std_logic;
    constant msg               : in string                 := check_result_tag_c;
    constant level             : in log_level_t := null_log_level;
    constant active_clock_edge : in edge_t                 := rising_edge;
    constant line_num          : in natural                := 0;
    constant file_name         : in string                 := "");

  procedure check_not_unknown(
    checker            :    checker_t;
    constant expr      : in std_logic;
    constant msg       : in string                 := check_result_tag_c;
    constant level     : in log_level_t := null_log_level;
    constant line_num  : in natural                := 0;
    constant file_name : in string                 := "");

  procedure check_not_unknown(
    checker            :     checker_t;
    variable pass      : out boolean;
    constant expr      : in  std_logic;
    constant msg       : in  string                 := check_result_tag_c;
    constant level     : in  log_level_t := null_log_level;
    constant line_num  : in  natural                := 0;
    constant file_name : in  string                 := "");

  procedure check_not_unknown(
    constant expr      : in std_logic;
    constant msg       : in string                 := check_result_tag_c;
    constant level     : in log_level_t := null_log_level;
    constant line_num  : in natural                := 0;
    constant file_name : in string                 := "");

  procedure check_not_unknown(
    variable pass      : out boolean;
    constant expr      : in  std_logic;
    constant msg       : in  string                 := check_result_tag_c;
    constant level     : in  log_level_t := null_log_level;
    constant line_num  : in  natural                := 0;
    constant file_name : in  string                 := "");

  impure function check_not_unknown(
    constant expr      : in std_logic;
    constant msg       : in string                 := check_result_tag_c;
    constant level     : in log_level_t := null_log_level;
    constant line_num  : in natural                := 0;
    constant file_name : in string                 := "")
    return boolean;

  -----------------------------------------------------------------------------
  -- check_zero_one_hot
  -----------------------------------------------------------------------------
  procedure check_zero_one_hot(
    checker                    :    checker_t;
    signal clock               : in std_logic;
    signal en                  : in std_logic;
    signal expr                : in std_logic_vector;
    constant msg               : in string                 := check_result_tag_c;
    constant level             : in log_level_t := null_log_level;
    constant active_clock_edge : in edge_t                 := rising_edge;
    constant line_num          : in natural                := 0;
    constant file_name         : in string                 := "");

  procedure check_zero_one_hot(
    signal clock               : in std_logic;
    signal en                  : in std_logic;
    signal expr                : in std_logic_vector;
    constant msg               : in string                 := check_result_tag_c;
    constant level             : in log_level_t := null_log_level;
    constant active_clock_edge : in edge_t                 := rising_edge;
    constant line_num          : in natural                := 0;
    constant file_name         : in string                 := "");

  procedure check_zero_one_hot(
    checker            :     checker_t;
    variable pass      : out boolean;
    constant expr      : in  std_logic_vector;
    constant msg       : in  string                 := check_result_tag_c;
    constant level     : in  log_level_t := null_log_level;
    constant line_num  : in  natural                := 0;
    constant file_name : in  string                 := "");

  procedure check_zero_one_hot(
    variable pass      : out boolean;
    constant expr      : in  std_logic_vector;
    constant msg       : in  string                 := check_result_tag_c;
    constant level     : in  log_level_t := null_log_level;
    constant line_num  : in  natural                := 0;
    constant file_name : in  string                 := "");

  impure function check_zero_one_hot(
    constant expr      : in std_logic_vector;
    constant msg       : in string                 := check_result_tag_c;
    constant level     : in log_level_t := null_log_level;
    constant line_num  : in natural                := 0;
    constant file_name : in string                 := "")
    return boolean;

  procedure check_zero_one_hot(
    checker            :    checker_t;
    constant expr      : in std_logic_vector;
    constant msg       : in string                 := check_result_tag_c;
    constant level     : in log_level_t := null_log_level;
    constant line_num  : in natural                := 0;
    constant file_name : in string                 := "");

  procedure check_zero_one_hot(
    constant expr      : in std_logic_vector;
    constant msg       : in string                 := check_result_tag_c;
    constant level     : in log_level_t := null_log_level;
    constant line_num  : in natural                := 0;
    constant file_name : in string                 := "");

  -----------------------------------------------------------------------------
  -- check_one_hot
  -----------------------------------------------------------------------------
  procedure check_one_hot(
    checker                    :    checker_t;
    signal clock               : in std_logic;
    signal en                  : in std_logic;
    signal expr                : in std_logic_vector;
    constant msg               : in string                 := check_result_tag_c;
    constant level             : in log_level_t := null_log_level;
    constant active_clock_edge : in edge_t                 := rising_edge;
    constant line_num          : in natural                := 0;
    constant file_name         : in string                 := "");

  procedure check_one_hot(
    signal clock               : in std_logic;
    signal en                  : in std_logic;
    signal expr                : in std_logic_vector;
    constant msg               : in string                 := check_result_tag_c;
    constant level             : in log_level_t := null_log_level;
    constant active_clock_edge : in edge_t                 := rising_edge;
    constant line_num          : in natural                := 0;
    constant file_name         : in string                 := "");

  procedure check_one_hot(
    checker            :     checker_t;
    variable pass      : out boolean;
    constant expr      : in  std_logic_vector;
    constant msg       : in  string                 := check_result_tag_c;
    constant level     : in  log_level_t := null_log_level;
    constant line_num  : in  natural                := 0;
    constant file_name : in  string                 := "");

  procedure check_one_hot(
    variable pass      : out boolean;
    constant expr      : in  std_logic_vector;
    constant msg       : in  string                 := check_result_tag_c;
    constant level     : in  log_level_t := null_log_level;
    constant line_num  : in  natural                := 0;
    constant file_name : in  string                 := "");

  impure function check_one_hot(
    constant expr      : in std_logic_vector;
    constant msg       : in string                 := check_result_tag_c;
    constant level     : in log_level_t := null_log_level;
    constant line_num  : in natural                := 0;
    constant file_name : in string                 := "")
    return boolean;

  procedure check_one_hot(
    checker            :    checker_t;
    constant expr      : in std_logic_vector;
    constant msg       : in string                 := check_result_tag_c;
    constant level     : in log_level_t := null_log_level;
    constant line_num  : in natural                := 0;
    constant file_name : in string                 := "");

  procedure check_one_hot(
    constant expr      : in std_logic_vector;
    constant msg       : in string                 := check_result_tag_c;
    constant level     : in log_level_t := null_log_level;
    constant line_num  : in natural                := 0;
    constant file_name : in string                 := "");

  -----------------------------------------------------------------------------
  -- check_next
  -----------------------------------------------------------------------------
  procedure check_next(
    checker                      :    checker_t;
    signal clock                 : in std_logic;
    signal en                    : in std_logic;
    signal start_event           : in std_logic;
    signal expr                  : in std_logic;
    constant msg                 : in string                 := check_result_tag_c;
    constant num_cks             : in natural                := 1;
    constant allow_overlapping   : in boolean                := true;
    constant allow_missing_start : in boolean                := true;
    constant level               : in log_level_t := null_log_level;
    constant active_clock_edge   : in edge_t                 := rising_edge;
    constant line_num            : in natural                := 0;
    constant file_name           : in string                 := "");

  procedure check_next(
    signal clock                 : in std_logic;
    signal en                    : in std_logic;
    signal start_event           : in std_logic;
    signal expr                  : in std_logic;
    constant msg                 : in string                 := check_result_tag_c;
    constant num_cks             : in natural                := 1;
    constant allow_overlapping   : in boolean                := true;
    constant allow_missing_start : in boolean                := true;
    constant level               : in log_level_t := null_log_level;
    constant active_clock_edge   : in edge_t                 := rising_edge;
    constant line_num            : in natural                := 0;
    constant file_name           : in string                 := "");

  -----------------------------------------------------------------------------
  -- check_sequence
  -----------------------------------------------------------------------------
  procedure check_sequence(
    checker                    :    checker_t;
    signal clock               : in std_logic;
    signal en                  : in std_logic;
    signal event_sequence      : in std_logic_vector;
    constant msg               : in string                 := check_result_tag_c;
    constant trigger_event     : in trigger_event_t        := penultimate;
    constant level             : in log_level_t := null_log_level;
    constant active_clock_edge : in edge_t                 := rising_edge;
    constant line_num          : in natural                := 0;
    constant file_name         : in string                 := "");

  procedure check_sequence(
    signal clock               : in std_logic;
    signal en                  : in std_logic;
    signal event_sequence      : in std_logic_vector;
    constant msg               : in string                 := check_result_tag_c;
    constant trigger_event     : in trigger_event_t        := penultimate;
    constant level             : in log_level_t := null_log_level;
    constant active_clock_edge : in edge_t                 := rising_edge;
    constant line_num          : in natural                := 0;
    constant file_name         : in string                 := "");

  -----------------------------------------------------------------------------
  -- check_relation
  -----------------------------------------------------------------------------
  procedure check_relation(
    checker              :    checker_t;
    constant expr        : in boolean;
    constant msg         : in string                 := check_result_tag_c;
    constant level       : in log_level_t := null_log_level;
    constant context_msg : in string                 := "";
    constant line_num    : in natural                := 0;
    constant file_name   : in string                 := "");

  procedure check_relation(
    checker              :     checker_t;
    variable pass        : out boolean;
    constant expr        : in  boolean;
    constant msg         : in  string                 := check_result_tag_c;
    constant level       : in  log_level_t := null_log_level;
    constant context_msg : in  string                 := "";
    constant line_num    : in  natural                := 0;
    constant file_name   : in  string                 := "");

  procedure check_relation(
    constant expr        : in boolean;
    constant msg         : in string                 := check_result_tag_c;
    constant level       : in log_level_t := null_log_level;
    constant context_msg : in string                 := "";
    constant line_num    : in natural                := 0;
    constant file_name   : in string                 := "");

  procedure check_relation(
    variable pass        : out boolean;
    constant expr        : in  boolean;
    constant msg         : in  string                 := check_result_tag_c;
    constant level       : in  log_level_t := null_log_level;
    constant context_msg : in  string                 := "";
    constant line_num    : in  natural                := 0;
    constant file_name   : in  string                 := "");

  impure function check_relation(
    constant expr        : in boolean;
    constant msg         : in string                 := check_result_tag_c;
    constant level       : in log_level_t := null_log_level;
    constant context_msg : in string                 := "";
    constant line_num    : in natural                := 0;
    constant file_name   : in string                 := "")
    return boolean;

  procedure check_relation(
    checker              :    checker_t;
    constant expr        : in std_ulogic;
    constant msg         : in string                 := check_result_tag_c;
    constant level       : in log_level_t := null_log_level;
    constant context_msg : in string                 := "";
    constant line_num    : in natural                := 0;
    constant file_name   : in string                 := "");

  procedure check_relation(
    checker              :     checker_t;
    variable pass        : out boolean;
    constant expr        : in  std_ulogic;
    constant msg         : in  string                 := check_result_tag_c;
    constant level       : in  log_level_t := null_log_level;
    constant context_msg : in  string                 := "";
    constant line_num    : in  natural                := 0;
    constant file_name   : in  string                 := "");

  procedure check_relation(
    constant expr        : in std_ulogic;
    constant msg         : in string                 := check_result_tag_c;
    constant level       : in log_level_t := null_log_level;
    constant context_msg : in string                 := "";
    constant line_num    : in natural                := 0;
    constant file_name   : in string                 := "");

  procedure check_relation(
    variable pass        : out boolean;
    constant expr        : in  std_ulogic;
    constant msg         : in  string                 := check_result_tag_c;
    constant level       : in  log_level_t := null_log_level;
    constant context_msg : in  string                 := "";
    constant line_num    : in  natural                := 0;
    constant file_name   : in  string                 := "");

  impure function check_relation(
    constant expr        : in std_ulogic;
    constant msg         : in string                 := check_result_tag_c;
    constant level       : in log_level_t := null_log_level;
    constant context_msg : in string                 := "";
    constant line_num    : in natural                := 0;
    constant file_name   : in string                 := "")
    return boolean;

  procedure check_relation(
    checker              :    checker_t;
    constant expr        : in bit;
    constant msg         : in string                 := check_result_tag_c;
    constant level       : in log_level_t := null_log_level;
    constant context_msg : in string                 := "";
    constant line_num    : in natural                := 0;
    constant file_name   : in string                 := "");

  procedure check_relation(
    checker              :     checker_t;
    variable pass        : out boolean;
    constant expr        : in  bit;
    constant msg         : in  string                 := check_result_tag_c;
    constant level       : in  log_level_t := null_log_level;
    constant context_msg : in  string                 := "";
    constant line_num    : in  natural                := 0;
    constant file_name   : in  string                 := "");

  procedure check_relation(
    constant expr        : in bit;
    constant msg         : in string                 := check_result_tag_c;
    constant level       : in log_level_t := null_log_level;
    constant context_msg : in string                 := "";
    constant line_num    : in natural                := 0;
    constant file_name   : in string                 := "");

  procedure check_relation(
    variable pass        : out boolean;
    constant expr        : in  bit;
    constant msg         : in  string                 := check_result_tag_c;
    constant level       : in  log_level_t := null_log_level;
    constant context_msg : in  string                 := "";
    constant line_num    : in  natural                := 0;
    constant file_name   : in  string                 := "");

  impure function check_relation(
    constant expr        : in bit;
    constant msg         : in string                 := check_result_tag_c;
    constant level       : in log_level_t := null_log_level;
    constant context_msg : in string                 := "";
    constant line_num    : in natural                := 0;
    constant file_name   : in string                 := "")
    return boolean;

  -----------------------------------------------------------------------------
  -- check_equal
  -----------------------------------------------------------------------------
  procedure check_equal(
    constant got             : in unsigned;
    constant expected        : in unsigned;
    constant msg             : in string := check_result_tag_c;
    constant level           : in log_level_t := null_log_level;
    constant line_num        : in natural     := 0;
    constant file_name       : in string      := "");

  procedure check_equal(
    variable pass            : out boolean;
    constant got             : in unsigned;
    constant expected        : in unsigned;
    constant msg             : in string := check_result_tag_c;
    constant level           : in log_level_t := null_log_level;
    constant line_num        : in natural     := 0;
    constant file_name       : in string      := "");

  procedure check_equal(
    constant checker         : in checker_t;
    variable pass            : out boolean;
    constant got             : in unsigned;
    constant expected        : in unsigned;
    constant msg             : in string := check_result_tag_c;
    constant level           : in log_level_t := null_log_level;
    constant line_num        : in natural     := 0;
    constant file_name       : in string      := "");

  procedure check_equal(
    constant checker         : in checker_t;
    constant got             : in unsigned;
    constant expected        : in unsigned;
    constant msg             : in string := check_result_tag_c;
    constant level           : in log_level_t := null_log_level;
    constant line_num        : in natural     := 0;
    constant file_name       : in string      := "");

  impure function check_equal(
    constant got             : in unsigned;
    constant expected        : in unsigned;
    constant msg             : in string := check_result_tag_c;
    constant level           : in log_level_t := null_log_level;
    constant line_num        : in natural     := 0;
    constant file_name       : in string      := "")
    return boolean;

  procedure check_equal(
    constant got             : in unsigned;
    constant expected        : in natural;
    constant msg             : in string := check_result_tag_c;
    constant level           : in log_level_t := null_log_level;
    constant line_num        : in natural     := 0;
    constant file_name       : in string      := "");

  procedure check_equal(
    variable pass            : out boolean;
    constant got             : in unsigned;
    constant expected        : in natural;
    constant msg             : in string := check_result_tag_c;
    constant level           : in log_level_t := null_log_level;
    constant line_num        : in natural     := 0;
    constant file_name       : in string      := "");

  procedure check_equal(
    constant checker         : in checker_t;
    variable pass            : out boolean;
    constant got             : in unsigned;
    constant expected        : in natural;
    constant msg             : in string := check_result_tag_c;
    constant level           : in log_level_t := null_log_level;
    constant line_num        : in natural     := 0;
    constant file_name       : in string      := "");

  procedure check_equal(
    constant checker         : in checker_t;
    constant got             : in unsigned;
    constant expected        : in natural;
    constant msg             : in string := check_result_tag_c;
    constant level           : in log_level_t := null_log_level;
    constant line_num        : in natural     := 0;
    constant file_name       : in string      := "");

  impure function check_equal(
    constant got             : in unsigned;
    constant expected        : in natural;
    constant msg             : in string := check_result_tag_c;
    constant level           : in log_level_t := null_log_level;
    constant line_num        : in natural     := 0;
    constant file_name       : in string      := "")
    return boolean;

  procedure check_equal(
    constant got             : in natural;
    constant expected        : in unsigned;
    constant msg             : in string := check_result_tag_c;
    constant level           : in log_level_t := null_log_level;
    constant line_num        : in natural     := 0;
    constant file_name       : in string      := "");

  procedure check_equal(
    variable pass            : out boolean;
    constant got             : in natural;
    constant expected        : in unsigned;
    constant msg             : in string := check_result_tag_c;
    constant level           : in log_level_t := null_log_level;
    constant line_num        : in natural     := 0;
    constant file_name       : in string      := "");

  procedure check_equal(
    constant checker         : in checker_t;
    variable pass            : out boolean;
    constant got             : in natural;
    constant expected        : in unsigned;
    constant msg             : in string := check_result_tag_c;
    constant level           : in log_level_t := null_log_level;
    constant line_num        : in natural     := 0;
    constant file_name       : in string      := "");

  procedure check_equal(
    constant checker         : in checker_t;
    constant got             : in natural;
    constant expected        : in unsigned;
    constant msg             : in string := check_result_tag_c;
    constant level           : in log_level_t := null_log_level;
    constant line_num        : in natural     := 0;
    constant file_name       : in string      := "");

  impure function check_equal(
    constant got             : in natural;
    constant expected        : in unsigned;
    constant msg             : in string := check_result_tag_c;
    constant level           : in log_level_t := null_log_level;
    constant line_num        : in natural     := 0;
    constant file_name       : in string      := "")
    return boolean;

  procedure check_equal(
    constant got             : in unsigned;
    constant expected        : in std_logic_vector;
    constant msg             : in string := check_result_tag_c;
    constant level           : in log_level_t := null_log_level;
    constant line_num        : in natural     := 0;
    constant file_name       : in string      := "");

  procedure check_equal(
    variable pass            : out boolean;
    constant got             : in unsigned;
    constant expected        : in std_logic_vector;
    constant msg             : in string := check_result_tag_c;
    constant level           : in log_level_t := null_log_level;
    constant line_num        : in natural     := 0;
    constant file_name       : in string      := "");

  procedure check_equal(
    constant checker         : in checker_t;
    variable pass            : out boolean;
    constant got             : in unsigned;
    constant expected        : in std_logic_vector;
    constant msg             : in string := check_result_tag_c;
    constant level           : in log_level_t := null_log_level;
    constant line_num        : in natural     := 0;
    constant file_name       : in string      := "");

  procedure check_equal(
    constant checker         : in checker_t;
    constant got             : in unsigned;
    constant expected        : in std_logic_vector;
    constant msg             : in string := check_result_tag_c;
    constant level           : in log_level_t := null_log_level;
    constant line_num        : in natural     := 0;
    constant file_name       : in string      := "");

  impure function check_equal(
    constant got             : in unsigned;
    constant expected        : in std_logic_vector;
    constant msg             : in string := check_result_tag_c;
    constant level           : in log_level_t := null_log_level;
    constant line_num        : in natural     := 0;
    constant file_name       : in string      := "")
    return boolean;

  procedure check_equal(
    constant got             : in std_logic_vector;
    constant expected        : in unsigned;
    constant msg             : in string := check_result_tag_c;
    constant level           : in log_level_t := null_log_level;
    constant line_num        : in natural     := 0;
    constant file_name       : in string      := "");

  procedure check_equal(
    variable pass            : out boolean;
    constant got             : in std_logic_vector;
    constant expected        : in unsigned;
    constant msg             : in string := check_result_tag_c;
    constant level           : in log_level_t := null_log_level;
    constant line_num        : in natural     := 0;
    constant file_name       : in string      := "");

  procedure check_equal(
    constant checker         : in checker_t;
    variable pass            : out boolean;
    constant got             : in std_logic_vector;
    constant expected        : in unsigned;
    constant msg             : in string := check_result_tag_c;
    constant level           : in log_level_t := null_log_level;
    constant line_num        : in natural     := 0;
    constant file_name       : in string      := "");

  procedure check_equal(
    constant checker         : in checker_t;
    constant got             : in std_logic_vector;
    constant expected        : in unsigned;
    constant msg             : in string := check_result_tag_c;
    constant level           : in log_level_t := null_log_level;
    constant line_num        : in natural     := 0;
    constant file_name       : in string      := "");

  impure function check_equal(
    constant got             : in std_logic_vector;
    constant expected        : in unsigned;
    constant msg             : in string := check_result_tag_c;
    constant level           : in log_level_t := null_log_level;
    constant line_num        : in natural     := 0;
    constant file_name       : in string      := "")
    return boolean;

  procedure check_equal(
    constant got             : in std_logic_vector;
    constant expected        : in std_logic_vector;
    constant msg             : in string := check_result_tag_c;
    constant level           : in log_level_t := null_log_level;
    constant line_num        : in natural     := 0;
    constant file_name       : in string      := "");

  procedure check_equal(
    variable pass            : out boolean;
    constant got             : in std_logic_vector;
    constant expected        : in std_logic_vector;
    constant msg             : in string := check_result_tag_c;
    constant level           : in log_level_t := null_log_level;
    constant line_num        : in natural     := 0;
    constant file_name       : in string      := "");

  procedure check_equal(
    constant checker         : in checker_t;
    variable pass            : out boolean;
    constant got             : in std_logic_vector;
    constant expected        : in std_logic_vector;
    constant msg             : in string := check_result_tag_c;
    constant level           : in log_level_t := null_log_level;
    constant line_num        : in natural     := 0;
    constant file_name       : in string      := "");

  procedure check_equal(
    constant checker         : in checker_t;
    constant got             : in std_logic_vector;
    constant expected        : in std_logic_vector;
    constant msg             : in string := check_result_tag_c;
    constant level           : in log_level_t := null_log_level;
    constant line_num        : in natural     := 0;
    constant file_name       : in string      := "");

  impure function check_equal(
    constant got             : in std_logic_vector;
    constant expected        : in std_logic_vector;
    constant msg             : in string := check_result_tag_c;
    constant level           : in log_level_t := null_log_level;
    constant line_num        : in natural     := 0;
    constant file_name       : in string      := "")
    return boolean;

  procedure check_equal(
    constant got             : in std_logic_vector;
    constant expected        : in natural;
    constant msg             : in string := check_result_tag_c;
    constant level           : in log_level_t := null_log_level;
    constant line_num        : in natural     := 0;
    constant file_name       : in string      := "");

  procedure check_equal(
    variable pass            : out boolean;
    constant got             : in std_logic_vector;
    constant expected        : in natural;
    constant msg             : in string := check_result_tag_c;
    constant level           : in log_level_t := null_log_level;
    constant line_num        : in natural     := 0;
    constant file_name       : in string      := "");

  procedure check_equal(
    constant checker         : in checker_t;
    variable pass            : out boolean;
    constant got             : in std_logic_vector;
    constant expected        : in natural;
    constant msg             : in string := check_result_tag_c;
    constant level           : in log_level_t := null_log_level;
    constant line_num        : in natural     := 0;
    constant file_name       : in string      := "");

  procedure check_equal(
    constant checker         : in checker_t;
    constant got             : in std_logic_vector;
    constant expected        : in natural;
    constant msg             : in string := check_result_tag_c;
    constant level           : in log_level_t := null_log_level;
    constant line_num        : in natural     := 0;
    constant file_name       : in string      := "");

  impure function check_equal(
    constant got             : in std_logic_vector;
    constant expected        : in natural;
    constant msg             : in string := check_result_tag_c;
    constant level           : in log_level_t := null_log_level;
    constant line_num        : in natural     := 0;
    constant file_name       : in string      := "")
    return boolean;

  procedure check_equal(
    constant got             : in natural;
    constant expected        : in std_logic_vector;
    constant msg             : in string := check_result_tag_c;
    constant level           : in log_level_t := null_log_level;
    constant line_num        : in natural     := 0;
    constant file_name       : in string      := "");

  procedure check_equal(
    variable pass            : out boolean;
    constant got             : in natural;
    constant expected        : in std_logic_vector;
    constant msg             : in string := check_result_tag_c;
    constant level           : in log_level_t := null_log_level;
    constant line_num        : in natural     := 0;
    constant file_name       : in string      := "");

  procedure check_equal(
    constant checker         : in checker_t;
    variable pass            : out boolean;
    constant got             : in natural;
    constant expected        : in std_logic_vector;
    constant msg             : in string := check_result_tag_c;
    constant level           : in log_level_t := null_log_level;
    constant line_num        : in natural     := 0;
    constant file_name       : in string      := "");

  procedure check_equal(
    constant checker         : in checker_t;
    constant got             : in natural;
    constant expected        : in std_logic_vector;
    constant msg             : in string := check_result_tag_c;
    constant level           : in log_level_t := null_log_level;
    constant line_num        : in natural     := 0;
    constant file_name       : in string      := "");

  impure function check_equal(
    constant got             : in natural;
    constant expected        : in std_logic_vector;
    constant msg             : in string := check_result_tag_c;
    constant level           : in log_level_t := null_log_level;
    constant line_num        : in natural     := 0;
    constant file_name       : in string      := "")
    return boolean;

  procedure check_equal(
    constant got             : in signed;
    constant expected        : in signed;
    constant msg             : in string := check_result_tag_c;
    constant level           : in log_level_t := null_log_level;
    constant line_num        : in natural     := 0;
    constant file_name       : in string      := "");

  procedure check_equal(
    variable pass            : out boolean;
    constant got             : in signed;
    constant expected        : in signed;
    constant msg             : in string := check_result_tag_c;
    constant level           : in log_level_t := null_log_level;
    constant line_num        : in natural     := 0;
    constant file_name       : in string      := "");

  procedure check_equal(
    constant checker         : in checker_t;
    variable pass            : out boolean;
    constant got             : in signed;
    constant expected        : in signed;
    constant msg             : in string := check_result_tag_c;
    constant level           : in log_level_t := null_log_level;
    constant line_num        : in natural     := 0;
    constant file_name       : in string      := "");

  procedure check_equal(
    constant checker         : in checker_t;
    constant got             : in signed;
    constant expected        : in signed;
    constant msg             : in string := check_result_tag_c;
    constant level           : in log_level_t := null_log_level;
    constant line_num        : in natural     := 0;
    constant file_name       : in string      := "");

  impure function check_equal(
    constant got             : in signed;
    constant expected        : in signed;
    constant msg             : in string := check_result_tag_c;
    constant level           : in log_level_t := null_log_level;
    constant line_num        : in natural     := 0;
    constant file_name       : in string      := "")
    return boolean;

  procedure check_equal(
    constant got             : in signed;
    constant expected        : in integer;
    constant msg             : in string := check_result_tag_c;
    constant level           : in log_level_t := null_log_level;
    constant line_num        : in natural     := 0;
    constant file_name       : in string      := "");

  procedure check_equal(
    variable pass            : out boolean;
    constant got             : in signed;
    constant expected        : in integer;
    constant msg             : in string := check_result_tag_c;
    constant level           : in log_level_t := null_log_level;
    constant line_num        : in natural     := 0;
    constant file_name       : in string      := "");

  procedure check_equal(
    constant checker         : in checker_t;
    variable pass            : out boolean;
    constant got             : in signed;
    constant expected        : in integer;
    constant msg             : in string := check_result_tag_c;
    constant level           : in log_level_t := null_log_level;
    constant line_num        : in natural     := 0;
    constant file_name       : in string      := "");

  procedure check_equal(
    constant checker         : in checker_t;
    constant got             : in signed;
    constant expected        : in integer;
    constant msg             : in string := check_result_tag_c;
    constant level           : in log_level_t := null_log_level;
    constant line_num        : in natural     := 0;
    constant file_name       : in string      := "");

  impure function check_equal(
    constant got             : in signed;
    constant expected        : in integer;
    constant msg             : in string := check_result_tag_c;
    constant level           : in log_level_t := null_log_level;
    constant line_num        : in natural     := 0;
    constant file_name       : in string      := "")
    return boolean;

  procedure check_equal(
    constant got             : in integer;
    constant expected        : in signed;
    constant msg             : in string := check_result_tag_c;
    constant level           : in log_level_t := null_log_level;
    constant line_num        : in natural     := 0;
    constant file_name       : in string      := "");

  procedure check_equal(
    variable pass            : out boolean;
    constant got             : in integer;
    constant expected        : in signed;
    constant msg             : in string := check_result_tag_c;
    constant level           : in log_level_t := null_log_level;
    constant line_num        : in natural     := 0;
    constant file_name       : in string      := "");

  procedure check_equal(
    constant checker         : in checker_t;
    variable pass            : out boolean;
    constant got             : in integer;
    constant expected        : in signed;
    constant msg             : in string := check_result_tag_c;
    constant level           : in log_level_t := null_log_level;
    constant line_num        : in natural     := 0;
    constant file_name       : in string      := "");

  procedure check_equal(
    constant checker         : in checker_t;
    constant got             : in integer;
    constant expected        : in signed;
    constant msg             : in string := check_result_tag_c;
    constant level           : in log_level_t := null_log_level;
    constant line_num        : in natural     := 0;
    constant file_name       : in string      := "");

  impure function check_equal(
    constant got             : in integer;
    constant expected        : in signed;
    constant msg             : in string := check_result_tag_c;
    constant level           : in log_level_t := null_log_level;
    constant line_num        : in natural     := 0;
    constant file_name       : in string      := "")
    return boolean;

  procedure check_equal(
    constant got             : in integer;
    constant expected        : in integer;
    constant msg             : in string := check_result_tag_c;
    constant level           : in log_level_t := null_log_level;
    constant line_num        : in natural     := 0;
    constant file_name       : in string      := "");

  procedure check_equal(
    variable pass            : out boolean;
    constant got             : in integer;
    constant expected        : in integer;
    constant msg             : in string := check_result_tag_c;
    constant level           : in log_level_t := null_log_level;
    constant line_num        : in natural     := 0;
    constant file_name       : in string      := "");

  procedure check_equal(
    constant checker         : in checker_t;
    variable pass            : out boolean;
    constant got             : in integer;
    constant expected        : in integer;
    constant msg             : in string := check_result_tag_c;
    constant level           : in log_level_t := null_log_level;
    constant line_num        : in natural     := 0;
    constant file_name       : in string      := "");

  procedure check_equal(
    constant checker         : in checker_t;
    constant got             : in integer;
    constant expected        : in integer;
    constant msg             : in string := check_result_tag_c;
    constant level           : in log_level_t := null_log_level;
    constant line_num        : in natural     := 0;
    constant file_name       : in string      := "");

  impure function check_equal(
    constant got             : in integer;
    constant expected        : in integer;
    constant msg             : in string := check_result_tag_c;
    constant level           : in log_level_t := null_log_level;
    constant line_num        : in natural     := 0;
    constant file_name       : in string      := "")
    return boolean;

  procedure check_equal(
    constant got             : in std_logic;
    constant expected        : in std_logic;
    constant msg             : in string := check_result_tag_c;
    constant level           : in log_level_t := null_log_level;
    constant line_num        : in natural     := 0;
    constant file_name       : in string      := "");

  procedure check_equal(
    variable pass            : out boolean;
    constant got             : in std_logic;
    constant expected        : in std_logic;
    constant msg             : in string := check_result_tag_c;
    constant level           : in log_level_t := null_log_level;
    constant line_num        : in natural     := 0;
    constant file_name       : in string      := "");

  procedure check_equal(
    constant checker         : in checker_t;
    variable pass            : out boolean;
    constant got             : in std_logic;
    constant expected        : in std_logic;
    constant msg             : in string := check_result_tag_c;
    constant level           : in log_level_t := null_log_level;
    constant line_num        : in natural     := 0;
    constant file_name       : in string      := "");

  procedure check_equal(
    constant checker         : in checker_t;
    constant got             : in std_logic;
    constant expected        : in std_logic;
    constant msg             : in string := check_result_tag_c;
    constant level           : in log_level_t := null_log_level;
    constant line_num        : in natural     := 0;
    constant file_name       : in string      := "");

  impure function check_equal(
    constant got             : in std_logic;
    constant expected        : in std_logic;
    constant msg             : in string := check_result_tag_c;
    constant level           : in log_level_t := null_log_level;
    constant line_num        : in natural     := 0;
    constant file_name       : in string      := "")
    return boolean;

  procedure check_equal(
    constant got             : in std_logic;
    constant expected        : in boolean;
    constant msg             : in string := check_result_tag_c;
    constant level           : in log_level_t := null_log_level;
    constant line_num        : in natural     := 0;
    constant file_name       : in string      := "");

  procedure check_equal(
    variable pass            : out boolean;
    constant got             : in std_logic;
    constant expected        : in boolean;
    constant msg             : in string := check_result_tag_c;
    constant level           : in log_level_t := null_log_level;
    constant line_num        : in natural     := 0;
    constant file_name       : in string      := "");

  procedure check_equal(
    constant checker         : in checker_t;
    variable pass            : out boolean;
    constant got             : in std_logic;
    constant expected        : in boolean;
    constant msg             : in string := check_result_tag_c;
    constant level           : in log_level_t := null_log_level;
    constant line_num        : in natural     := 0;
    constant file_name       : in string      := "");

  procedure check_equal(
    constant checker         : in checker_t;
    constant got             : in std_logic;
    constant expected        : in boolean;
    constant msg             : in string := check_result_tag_c;
    constant level           : in log_level_t := null_log_level;
    constant line_num        : in natural     := 0;
    constant file_name       : in string      := "");

  impure function check_equal(
    constant got             : in std_logic;
    constant expected        : in boolean;
    constant msg             : in string := check_result_tag_c;
    constant level           : in log_level_t := null_log_level;
    constant line_num        : in natural     := 0;
    constant file_name       : in string      := "")
    return boolean;

  procedure check_equal(
    constant got             : in boolean;
    constant expected        : in std_logic;
    constant msg             : in string := check_result_tag_c;
    constant level           : in log_level_t := null_log_level;
    constant line_num        : in natural     := 0;
    constant file_name       : in string      := "");

  procedure check_equal(
    variable pass            : out boolean;
    constant got             : in boolean;
    constant expected        : in std_logic;
    constant msg             : in string := check_result_tag_c;
    constant level           : in log_level_t := null_log_level;
    constant line_num        : in natural     := 0;
    constant file_name       : in string      := "");

  procedure check_equal(
    constant checker         : in checker_t;
    variable pass            : out boolean;
    constant got             : in boolean;
    constant expected        : in std_logic;
    constant msg             : in string := check_result_tag_c;
    constant level           : in log_level_t := null_log_level;
    constant line_num        : in natural     := 0;
    constant file_name       : in string      := "");

  procedure check_equal(
    constant checker         : in checker_t;
    constant got             : in boolean;
    constant expected        : in std_logic;
    constant msg             : in string := check_result_tag_c;
    constant level           : in log_level_t := null_log_level;
    constant line_num        : in natural     := 0;
    constant file_name       : in string      := "");

  impure function check_equal(
    constant got             : in boolean;
    constant expected        : in std_logic;
    constant msg             : in string := check_result_tag_c;
    constant level           : in log_level_t := null_log_level;
    constant line_num        : in natural     := 0;
    constant file_name       : in string      := "")
    return boolean;

  procedure check_equal(
    constant got             : in boolean;
    constant expected        : in boolean;
    constant msg             : in string := check_result_tag_c;
    constant level           : in log_level_t := null_log_level;
    constant line_num        : in natural     := 0;
    constant file_name       : in string      := "");

  procedure check_equal(
    variable pass            : out boolean;
    constant got             : in boolean;
    constant expected        : in boolean;
    constant msg             : in string := check_result_tag_c;
    constant level           : in log_level_t := null_log_level;
    constant line_num        : in natural     := 0;
    constant file_name       : in string      := "");

  procedure check_equal(
    constant checker         : in checker_t;
    variable pass            : out boolean;
    constant got             : in boolean;
    constant expected        : in boolean;
    constant msg             : in string := check_result_tag_c;
    constant level           : in log_level_t := null_log_level;
    constant line_num        : in natural     := 0;
    constant file_name       : in string      := "");

  procedure check_equal(
    constant checker         : in checker_t;
    constant got             : in boolean;
    constant expected        : in boolean;
    constant msg             : in string := check_result_tag_c;
    constant level           : in log_level_t := null_log_level;
    constant line_num        : in natural     := 0;
    constant file_name       : in string      := "");

  impure function check_equal(
    constant got             : in boolean;
    constant expected        : in boolean;
    constant msg             : in string := check_result_tag_c;
    constant level           : in log_level_t := null_log_level;
    constant line_num        : in natural     := 0;
    constant file_name       : in string      := "")
    return boolean;

  procedure check_equal(
    constant got             : in string;
    constant expected        : in string;
    constant msg             : in string := check_result_tag_c;
    constant level           : in log_level_t := null_log_level;
    constant line_num        : in natural     := 0;
    constant file_name       : in string      := "");

  procedure check_equal(
    variable pass            : out boolean;
    constant got             : in string;
    constant expected        : in string;
    constant msg             : in string := check_result_tag_c;
    constant level           : in log_level_t := null_log_level;
    constant line_num        : in natural     := 0;
    constant file_name       : in string      := "");

  procedure check_equal(
    constant checker         : in checker_t;
    variable pass            : out boolean;
    constant got             : in string;
    constant expected        : in string;
    constant msg             : in string := check_result_tag_c;
    constant level           : in log_level_t := null_log_level;
    constant line_num        : in natural     := 0;
    constant file_name       : in string      := "");

  procedure check_equal(
    constant checker         : in checker_t;
    constant got             : in string;
    constant expected        : in string;
    constant msg             : in string := check_result_tag_c;
    constant level           : in log_level_t := null_log_level;
    constant line_num        : in natural     := 0;
    constant file_name       : in string      := "");

  impure function check_equal(
    constant got             : in string;
    constant expected        : in string;
    constant msg             : in string := check_result_tag_c;
    constant level           : in log_level_t := null_log_level;
    constant line_num        : in natural     := 0;
    constant file_name       : in string      := "")
    return boolean;

  procedure check_equal(
    constant got             : in time;
    constant expected        : in time;
    constant msg             : in string := check_result_tag_c;
    constant level           : in log_level_t := null_log_level;
    constant line_num        : in natural     := 0;
    constant file_name       : in string      := "");

  procedure check_equal(
    variable pass            : out boolean;
    constant got             : in time;
    constant expected        : in time;
    constant msg             : in string := check_result_tag_c;
    constant level           : in log_level_t := null_log_level;
    constant line_num        : in natural     := 0;
    constant file_name       : in string      := "");

  procedure check_equal(
    constant checker         : in checker_t;
    variable pass            : out boolean;
    constant got             : in time;
    constant expected        : in time;
    constant msg             : in string := check_result_tag_c;
    constant level           : in log_level_t := null_log_level;
    constant line_num        : in natural     := 0;
    constant file_name       : in string      := "");

  procedure check_equal(
    constant checker         : in checker_t;
    constant got             : in time;
    constant expected        : in time;
    constant msg             : in string := check_result_tag_c;
    constant level           : in log_level_t := null_log_level;
    constant line_num        : in natural     := 0;
    constant file_name       : in string      := "");

  impure function check_equal(
    constant got             : in time;
    constant expected        : in time;
    constant msg             : in string := check_result_tag_c;
    constant level           : in log_level_t := null_log_level;
    constant line_num        : in natural     := 0;
    constant file_name       : in string      := "")
    return boolean;

  -----------------------------------------------------------------------------
  -- check_match
  -----------------------------------------------------------------------------
  procedure check_match(
    constant got             : in unsigned;
    constant expected        : in unsigned;
    constant msg             : in string := check_result_tag_c;
    constant level           : in log_level_t := null_log_level;
    constant line_num        : in natural     := 0;
    constant file_name       : in string      := "");

  procedure check_match(
    variable pass            : out boolean;
    constant got             : in unsigned;
    constant expected        : in unsigned;
    constant msg             : in string := check_result_tag_c;
    constant level           : in log_level_t := null_log_level;
    constant line_num        : in natural     := 0;
    constant file_name       : in string      := "");

  procedure check_match(
    constant checker         : in checker_t;
    variable pass            : out boolean;
    constant got             : in unsigned;
    constant expected        : in unsigned;
    constant msg             : in string := check_result_tag_c;
    constant level           : in log_level_t := null_log_level;
    constant line_num        : in natural     := 0;
    constant file_name       : in string      := "");

  procedure check_match(
    constant checker         : in checker_t;
    constant got             : in unsigned;
    constant expected        : in unsigned;
    constant msg             : in string := check_result_tag_c;
    constant level           : in log_level_t := null_log_level;
    constant line_num        : in natural     := 0;
    constant file_name       : in string      := "");

  impure function check_match(
    constant got             : in unsigned;
    constant expected        : in unsigned;
    constant msg             : in string := check_result_tag_c;
    constant level           : in log_level_t := null_log_level;
    constant line_num        : in natural     := 0;
    constant file_name       : in string      := "")
    return boolean;

  procedure check_match(
    constant got             : in std_logic_vector;
    constant expected        : in std_logic_vector;
    constant msg             : in string := check_result_tag_c;
    constant level           : in log_level_t := null_log_level;
    constant line_num        : in natural     := 0;
    constant file_name       : in string      := "");

  procedure check_match(
    variable pass            : out boolean;
    constant got             : in std_logic_vector;
    constant expected        : in std_logic_vector;
    constant msg             : in string := check_result_tag_c;
    constant level           : in log_level_t := null_log_level;
    constant line_num        : in natural     := 0;
    constant file_name       : in string      := "");

  procedure check_match(
    constant checker         : in checker_t;
    variable pass            : out boolean;
    constant got             : in std_logic_vector;
    constant expected        : in std_logic_vector;
    constant msg             : in string := check_result_tag_c;
    constant level           : in log_level_t := null_log_level;
    constant line_num        : in natural     := 0;
    constant file_name       : in string      := "");

  procedure check_match(
    constant checker         : in checker_t;
    constant got             : in std_logic_vector;
    constant expected        : in std_logic_vector;
    constant msg             : in string := check_result_tag_c;
    constant level           : in log_level_t := null_log_level;
    constant line_num        : in natural     := 0;
    constant file_name       : in string      := "");

  impure function check_match(
    constant got             : in std_logic_vector;
    constant expected        : in std_logic_vector;
    constant msg             : in string := check_result_tag_c;
    constant level           : in log_level_t := null_log_level;
    constant line_num        : in natural     := 0;
    constant file_name       : in string      := "")
    return boolean;

  procedure check_match(
    constant got             : in signed;
    constant expected        : in signed;
    constant msg             : in string := check_result_tag_c;
    constant level           : in log_level_t := null_log_level;
    constant line_num        : in natural     := 0;
    constant file_name       : in string      := "");

  procedure check_match(
    variable pass            : out boolean;
    constant got             : in signed;
    constant expected        : in signed;
    constant msg             : in string := check_result_tag_c;
    constant level           : in log_level_t := null_log_level;
    constant line_num        : in natural     := 0;
    constant file_name       : in string      := "");

  procedure check_match(
    constant checker         : in checker_t;
    variable pass            : out boolean;
    constant got             : in signed;
    constant expected        : in signed;
    constant msg             : in string := check_result_tag_c;
    constant level           : in log_level_t := null_log_level;
    constant line_num        : in natural     := 0;
    constant file_name       : in string      := "");

  procedure check_match(
    constant checker         : in checker_t;
    constant got             : in signed;
    constant expected        : in signed;
    constant msg             : in string := check_result_tag_c;
    constant level           : in log_level_t := null_log_level;
    constant line_num        : in natural     := 0;
    constant file_name       : in string      := "");

  impure function check_match(
    constant got             : in signed;
    constant expected        : in signed;
    constant msg             : in string := check_result_tag_c;
    constant level           : in log_level_t := null_log_level;
    constant line_num        : in natural     := 0;
    constant file_name       : in string      := "")
    return boolean;

  procedure check_match(
    constant got             : in std_logic;
    constant expected        : in std_logic;
    constant msg             : in string := check_result_tag_c;
    constant level           : in log_level_t := null_log_level;
    constant line_num        : in natural     := 0;
    constant file_name       : in string      := "");

  procedure check_match(
    variable pass            : out boolean;
    constant got             : in std_logic;
    constant expected        : in std_logic;
    constant msg             : in string := check_result_tag_c;
    constant level           : in log_level_t := null_log_level;
    constant line_num        : in natural     := 0;
    constant file_name       : in string      := "");

  procedure check_match(
    constant checker         : in checker_t;
    variable pass            : out boolean;
    constant got             : in std_logic;
    constant expected        : in std_logic;
    constant msg             : in string := check_result_tag_c;
    constant level           : in log_level_t := null_log_level;
    constant line_num        : in natural     := 0;
    constant file_name       : in string      := "");

  procedure check_match(
    constant checker         : in checker_t;
    constant got             : in std_logic;
    constant expected        : in std_logic;
    constant msg             : in string := check_result_tag_c;
    constant level           : in log_level_t := null_log_level;
    constant line_num        : in natural     := 0;
    constant file_name       : in string      := "");

  impure function check_match(
    constant got             : in std_logic;
    constant expected        : in std_logic;
    constant msg             : in string := check_result_tag_c;
    constant level           : in log_level_t := null_log_level;
    constant line_num        : in natural     := 0;
    constant file_name       : in string      := "")
    return boolean;

  -----------------------------------------------------------------------------

end package;
